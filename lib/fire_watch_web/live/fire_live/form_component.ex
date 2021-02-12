defmodule FireWatchWeb.FireLive.FormComponent do
  use FireWatchWeb, :live_component

  alias FireWatch.Fires
  alias FireWatch.Fires.Fire

  @impl true
  def update(%{fire: fire} = assigns, socket) do
    changeset = Fires.change_fire(fire)

    {:ok,
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
      |> assign(:day_options, Fire.get_days())
      |> assign(:month_options, Fire.get_months())
    }
  end

  @impl true
  def handle_event("validate", %{"fire" => fire_params}, socket) do
    changeset =
      socket.assigns.fire
      |> Fires.change_fire(fire_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"fire" => fire_params}, socket) do
    save_fire(socket, socket.assigns.action, fire_params)
  end

  defp save_fire(socket, :edit, fire_params) do
    case Fires.update_fire(socket.assigns.fire, fire_params) do
      {:ok, _fire} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fire report updated successfully")
         |> push_patch(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_fire(socket, :new, fire_params) do
    case Fires.create_fire(fire_params) do
      {:ok, _fire} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fire created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
