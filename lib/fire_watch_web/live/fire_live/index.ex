defmodule FireWatchWeb.FireLive.Index do
  use FireWatchWeb, :live_view

  alias FireWatch.Fires
  alias FireWatch.Fires.Fire

  @impl true
  def mount(_params, _session, socket) do
    paginate_options = %{page: 1, per_page: 10}
    fires = Fires.list_fires(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        fires: fires
      )
    {:ok, socket, temporary_assigns: [fires: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    paginate_options = %{page: page, per_page: per_page}
    fires = Fires.list_fires(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        fires: fires
      )

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do

    socket
    |> assign(:page_title, "Edit Fire Report")
    |> assign(:fire, Fires.get_fire!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fire Report")
    |> assign(:fire, %Fire{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fire Reports")
    |> assign(:fire, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fire = Fires.get_fire!(id)
    {:ok, _} = Fires.delete_fire(fire)

    {:noreply, assign(socket, :fires, list_fires())}
  end

  defp list_fires do
    Fires.list_fires()
  end
end
