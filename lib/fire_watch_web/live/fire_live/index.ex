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
    per_page = String.to_integer(params["per_page"] || "10")
    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}
    fires = Fires.list_fires(paginate: paginate_options, sort: sort_options)

    socket =
      assign(socket,
        options: Map.merge(paginate_options, sort_options),
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

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to: Routes.fire_index_path(socket, :index,
          page: socket.assigns.options.page,
          per_page: per_page,
          sort_by: socket.assigns.options.sort_by,
          sort_order: socket.assigns.options.sort_order
        )
      )

    {:noreply, socket}
  end

  defp pagination_link(socket, text, page, options, class) do
    live_patch text,
      to: Routes.fire_index_path(
        socket,
        :index,
        page: page,
        per_page: options.per_page,
        sort_by: options.sort_by,
        sort_order: options.sort_order
      ),
      class: class
  end

  defp sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort_by do
        text <> get_emoji(options.sort_order)
      else
        text
      end

    live_patch text,
      to: Routes.fire_index_path(socket, :index,
        sort_by: sort_by,
        sort_order: toggle_order(options.sort_order, sort_by == options.sort_by),
        page: options.page,
        per_page: options.per_page
      )
  end

  defp list_fires do
    Fires.list_fires()
  end

  defp toggle_order(:asc, true), do: :desc
  defp toggle_order(:asc, false), do: :asc
  defp toggle_order(:desc, true), do: :asc
  defp toggle_order(:desc, false), do: :asc

  defp get_emoji(:asc), do: " ↓"
  defp get_emoji(:desc), do: " ↑"
end
