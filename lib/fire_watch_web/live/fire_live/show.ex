defmodule FireWatchWeb.FireLive.Show do
  use FireWatchWeb, :live_view

  alias FireWatch.Fires

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fire, Fires.get_fire!(id))}
  end

  defp page_title(:show), do: "Show Fire"
  defp page_title(:edit), do: "Edit Fire"
end
