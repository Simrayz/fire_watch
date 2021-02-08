defmodule FireWatch.FiresTest do
  use FireWatch.DataCase

  alias FireWatch.Fires

  describe "fires" do
    alias FireWatch.Fires.Fire

    @valid_attrs %{area: 120.5, day: "some day", month: "some month", rain: 120.5, rh: 120.5, temp: 120.5, wind: 120.5}
    @update_attrs %{area: 456.7, day: "some updated day", month: "some updated month", rain: 456.7, rh: 456.7, temp: 456.7, wind: 456.7}
    @invalid_attrs %{area: nil, day: nil, month: nil, rain: nil, rh: nil, temp: nil, wind: nil}

    def fire_fixture(attrs \\ %{}) do
      {:ok, fire} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fires.create_fire()

      fire
    end

    test "list_fires/0 returns all fires" do
      fire = fire_fixture()
      assert Fires.list_fires() == [fire]
    end

    test "get_fire!/1 returns the fire with given id" do
      fire = fire_fixture()
      assert Fires.get_fire!(fire.id) == fire
    end

    test "create_fire/1 with valid data creates a fire" do
      assert {:ok, %Fire{} = fire} = Fires.create_fire(@valid_attrs)
      assert fire.area == 120.5
      assert fire.day == "some day"
      assert fire.month == "some month"
      assert fire.rain == 120.5
      assert fire.rh == 120.5
      assert fire.temp == 120.5
      assert fire.wind == 120.5
    end

    test "create_fire/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fires.create_fire(@invalid_attrs)
    end

    test "update_fire/2 with valid data updates the fire" do
      fire = fire_fixture()
      assert {:ok, %Fire{} = fire} = Fires.update_fire(fire, @update_attrs)
      assert fire.area == 456.7
      assert fire.day == "some updated day"
      assert fire.month == "some updated month"
      assert fire.rain == 456.7
      assert fire.rh == 456.7
      assert fire.temp == 456.7
      assert fire.wind == 456.7
    end

    test "update_fire/2 with invalid data returns error changeset" do
      fire = fire_fixture()
      assert {:error, %Ecto.Changeset{}} = Fires.update_fire(fire, @invalid_attrs)
      assert fire == Fires.get_fire!(fire.id)
    end

    test "delete_fire/1 deletes the fire" do
      fire = fire_fixture()
      assert {:ok, %Fire{}} = Fires.delete_fire(fire)
      assert_raise Ecto.NoResultsError, fn -> Fires.get_fire!(fire.id) end
    end

    test "change_fire/1 returns a fire changeset" do
      fire = fire_fixture()
      assert %Ecto.Changeset{} = Fires.change_fire(fire)
    end
  end
end
