defmodule FireWatchWeb.FireLive.Index do
  use FireWatchWeb, :live_view

  alias FireWatch.Fires
  alias FireWatch.Fires.Fire

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :fires, list_fires())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fire")
    |> assign(:fire, Fires.get_fire!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fire")
    |> assign(:fire, %Fire{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fires")
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
