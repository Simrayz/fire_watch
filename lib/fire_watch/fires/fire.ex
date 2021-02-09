defmodule FireWatch.Fires.Fire do
  use Ecto.Schema
  import Ecto.Changeset

  # Define options for month and day as string values.
  @month_options ~w"jan feb mar apr may jun jul aug sep oct nov dec"
  @day_options ~w"mon tue wed thu fri sat sun"

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
    |> validate_inclusion(:day, @day_options)
    |> validate_inclusion(:month, @month_options)
  end

  @doc "Returns month options for use in form selects"
  def get_months do
    @month_options
  end

  @doc "Returns day options for use in form selects"
  def get_days do
    @day_options
  end
end
