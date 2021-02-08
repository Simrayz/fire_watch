defmodule FireWatch.Fires.Fire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fires" do
    field :area, :float
    field :day, :string
    field :month, :string
    field :rain, :float
    field :rh, :float
    field :temp, :float
    field :wind, :float

    timestamps()
  end

  @doc false
  def changeset(fire, attrs) do
    fire
    |> cast(attrs, [:month, :day, :temp, :rh, :wind, :rain, :area])
    |> validate_required([:month, :day, :temp, :rh, :wind, :rain, :area])
  end
end
