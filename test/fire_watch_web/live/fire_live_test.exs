defmodule FireWatchWeb.FireLiveTest do
  use FireWatchWeb.ConnCase

  import Phoenix.LiveViewTest

  alias FireWatch.Fires

  @create_attrs %{area: 120.5, day: "some day", month: "some month", rain: 120.5, rh: 120.5, temp: 120.5, wind: 120.5}
  @update_attrs %{area: 456.7, day: "some updated day", month: "some updated month", rain: 456.7, rh: 456.7, temp: 456.7, wind: 456.7}
  @invalid_attrs %{area: nil, day: nil, month: nil, rain: nil, rh: nil, temp: nil, wind: nil}

  defp fixture(:fire) do
    {:ok, fire} = Fires.create_fire(@create_attrs)
    fire
  end

  defp create_fire(_) do
    fire = fixture(:fire)
    %{fire: fire}
  end

  describe "Index" do
    setup [:create_fire]

    test "lists all fires", %{conn: conn, fire: fire} do
      {:ok, _index_live, html} = live(conn, Routes.fire_index_path(conn, :index))

      assert html =~ "Listing Fires"
      assert html =~ fire.day
    end

    test "saves new fire", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.fire_index_path(conn, :index))

      assert index_live |> element("a", "New Fire") |> render_click() =~
               "New Fire"

      assert_patch(index_live, Routes.fire_index_path(conn, :new))

      assert index_live
             |> form("#fire-form", fire: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fire-form", fire: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fire_index_path(conn, :index))

      assert html =~ "Fire created successfully"
      assert html =~ "some day"
    end

    test "updates fire in listing", %{conn: conn, fire: fire} do
      {:ok, index_live, _html} = live(conn, Routes.fire_index_path(conn, :index))

      assert index_live |> element("#fire-#{fire.id} a", "Edit") |> render_click() =~
               "Edit Fire"

      assert_patch(index_live, Routes.fire_index_path(conn, :edit, fire))

      assert index_live
             |> form("#fire-form", fire: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fire-form", fire: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fire_index_path(conn, :index))

      assert html =~ "Fire updated successfully"
      assert html =~ "some updated day"
    end

    test "deletes fire in listing", %{conn: conn, fire: fire} do
      {:ok, index_live, _html} = live(conn, Routes.fire_index_path(conn, :index))

      assert index_live |> element("#fire-#{fire.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fire-#{fire.id}")
    end
  end

  describe "Show" do
    setup [:create_fire]

    test "displays fire", %{conn: conn, fire: fire} do
      {:ok, _show_live, html} = live(conn, Routes.fire_show_path(conn, :show, fire))

      assert html =~ "Show Fire"
      assert html =~ fire.day
    end

    test "updates fire within modal", %{conn: conn, fire: fire} do
      {:ok, show_live, _html} = live(conn, Routes.fire_show_path(conn, :show, fire))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fire"

      assert_patch(show_live, Routes.fire_show_path(conn, :edit, fire))

      assert show_live
             |> form("#fire-form", fire: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#fire-form", fire: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fire_show_path(conn, :show, fire))

      assert html =~ "Fire updated successfully"
      assert html =~ "some updated day"
    end
  end
end
