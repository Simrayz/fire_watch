defmodule FireWatch.Fires.CSV do
  @moduledoc """
  A module to hold functions used to load and convert forest fire data.
  """

  alias FireWatch.Fires.Fire
  alias FireWatch.Repo

  @doc """
  Import fires from csv file in root directory.
  """
  def import_fires(filename \\ "forestfires.csv") do
    filename
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end

  @doc """
  Convert raw fire to support table columns.
  Requires a map with csv headers as keys,
  and column values as values.
  """
  def convert_fires(fires_csv) do
    fires_csv
    |> Enum.map(fn attrs ->
      attrs = attrs |> Map.put("rh", attrs["RH"])

      %Fire{}
      |> Fire.changeset(attrs)
    end)
  end

  @doc """
  Takes fire changesets and inserts them all in one go.
  """
  def batch_insert(fires) do
    Enum.each(fires, fn fire ->
      Repo.insert!(fire)
    end)
  end

end
