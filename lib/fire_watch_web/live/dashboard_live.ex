defmodule FireWatchWeb.PageLive do
  use FireWatchWeb, :live_view
  alias FireWatch.Fires
  alias FireWatchWeb.FireLive.TableComponent

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Fires.subscribe()

    {:ok,
      assign(socket, query: "", results: %{})
      |> fetch_data()
    }
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end


  @impl true
  def handle_info({:updated, _updated_fire}, socket) do
    {:noreply, fetch_data(socket)}
  end

  def handle_info({:created, fire}, socket) do
    {:noreply, update(socket, :fires, fn fires -> [ fire | fires] |> Enum.take(5) end)}
  end

  def handle_info({:deleted, del_fire}, socket) do
    case Enum.find(socket.assigns.fires, fn fire -> del_fire.id == fire.id end) do
      nil ->
        {:noreply, socket}
      _else ->
        {:noreply, fetch_data(socket)}
    end
  end

  def handle_info(event_res, socket) do
    IO.inspect(event_res)
    {:noreply, socket}
  end

  defp search(query) do
    if not FireWatchWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end

  defp fetch_data(socket) do
    assign(socket, fires: Fires.list_recent_fires(5))
  end
end
