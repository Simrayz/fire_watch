defmodule FireWatchWeb.FireLive.TableRowComponent do
  use FireWatchWeb, :live_component

  def render(assigns) do
    ~L"""
    <tr id="fire-<%= @fire.id %>" class="text-yellow-900 text-center even:bg-yellow-600 even:bg-opacity-10">
      <td class="text-gray-600 py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.id %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.month %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.day %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.temp %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.wind %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.rh %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.rain %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= @fire.area %></td>
      <td class="py-2 px-3 border-r border-yellow-600 border-opacity-25"><%= NaiveDateTime.to_string(@fire.updated_at) %></td>

      <td>
        <span><%= live_patch "Edit", to: Routes.fire_index_path(@socket, :edit, @fire, @options), class: "btn-secondary btn-sm" %></span>
        <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @fire.id, data: [confirm: "Are you sure?"], class: "btn-secondary btn-sm" %></span>
      </td>
    </tr>
    """
  end

end
