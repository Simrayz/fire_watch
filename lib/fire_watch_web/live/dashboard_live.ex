defmodule FireWatchWeb.DashboardLive do
  use FireWatchWeb, :live_view
  alias FireWatch.Fires
  alias FireWatchWeb.FireLive.TableComponent

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Fires.subscribe()

    {:ok,
      assign(socket,
        query: "",
        results: %{},
        count: Fires.get_total_fires(),
        top_months:  Fires.list_category_counts() |> get_top_months(6)
      )
      |> fetch_data()
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fire = Fires.get_fire!(id)
    {:ok, _} = Fires.delete_fire(fire)

    {:noreply, socket}
  end

  @impl true
  def handle_info({:updated, _updated_fire}, socket) do
    {:noreply, fetch_data(socket)}
  end

  def handle_info({:created, fire}, socket) do
    {:noreply,
      update(socket, :fires, fn fires -> [ fire | fires] |> Enum.take(5) end)
      |> assign(:count, socket.assigns.count + 1)
      |> assign(:top_months, Enum.map(socket.assigns.top_months, fn {mon, val} ->
        if mon == fire.month do
          {mon, val + 1}
        else
          {mon, val}
        end
      end))
    }
  end

  def handle_info({:deleted, del_fire}, socket) do
    socket = assign(socket, :count, socket.assigns.count - 1)
    case Enum.find(socket.assigns.fires, fn fire -> del_fire.id == fire.id end) do
      nil ->
        {:noreply, assign(socket, count: socket.assigns.count - 1)}
      _else ->
        {:noreply, fetch_data(socket) |> assign(count: socket.assigns.count - 1)}
    end
  end

  def handle_info(event_res, socket) do
    IO.inspect(event_res)
    {:noreply, socket}
  end

  defp fetch_data(socket) do
    assign(socket, fires: Fires.list_recent_fires(5), top_months:  Fires.list_category_counts() |> get_top_months(6))
  end

  defp get_top_months(month_map, amount) do
    month_map
    |> Enum.sort_by(fn {_k, v} -> v end, &>=/2)
    |> Enum.take(amount)
  end
end
