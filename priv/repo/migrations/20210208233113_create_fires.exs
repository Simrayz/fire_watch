defmodule FireWatch.Repo.Migrations.CreateFires do
  use Ecto.Migration

  def change do
    create table(:fires) do
      add :month, :string
      add :day, :string
      add :temp, :float
      add :rh, :float
      add :wind, :float
      add :rain, :float
      add :area, :float

      timestamps()
    end

    create index(:fires, [:month])

  end
end
