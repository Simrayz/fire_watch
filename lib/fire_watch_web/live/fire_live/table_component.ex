defmodule FireWatchWeb.FireLive.TableComponent do
  use FireWatchWeb, :live_component
  alias FireWatchWeb.FireLive.TableRowComponent

  def render(assigns) do
    ~L"""
    <table class="table-auto min-w-full border-b border-yellow-600 border-opacity-25">
      <thead>
        <tr class="bg-yellow-600 rounded-md text-white text-sm font-light">
          <th class="py-2 px-2"><%= sort_link(@socket, "ID", :id, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Month", :month, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Week day", :day, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Temp (°C)", :temp, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Wind (km/h)", :wind, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "RH (%)", :rh, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Rain (mm/m2)", :rain, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Area (ha)", :area, @options) %></th>
          <th class="py-2 px-2"><%= sort_link(@socket, "Updated", :updated_at, @options) %></th>
          <th class="py-2 px-2"></th>
        </tr>
      </thead>
      <tbody id="fires" class="divide-solid" phx-update=“prepend”>
        <%= for {fire, idx} <- Enum.with_index(@fires) do %>
          <%= live_component @socket, TableRowComponent, id: "#{fire.id}", fire: fire, idx: idx %>
        <% end %>
      </tbody>
    </table>
    """
  end

  defp sort_link(_socket, text, _sort_by, %{ paginate: false }) do
    text
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
        page: update_page(options, sort_by),
        per_page: options.per_page
      )
  end

  defp toggle_order(:asc, true), do: :desc
  defp toggle_order(:asc, false), do: :asc
  defp toggle_order(:desc, true), do: :asc
  defp toggle_order(:desc, false), do: :asc

  defp update_page(options, sort_by) do
    if sort_by != options.sort_by do
      1
    else
      options.page
    end
  end

  defp get_emoji(:asc), do: " ↓"
  defp get_emoji(:desc), do: " ↑"
end
