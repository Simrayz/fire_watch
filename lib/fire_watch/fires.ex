defmodule FireWatch.Fires do
  @moduledoc """
  The Fires context.
  """

  import Ecto.Query, warn: false
  alias FireWatch.Repo

  alias FireWatch.Fires.Fire

  @doc """
  Returns the list of fires.

  ## Examples

      iex> list_fires()
      [%Fire{}, ...]

  """
  def list_fires do
    Repo.all(Fire)
  end

  @doc """
  Returns a list of fires matching the given 'criteria'.
  Example criteria:
  [
    paginate: %{page: 2, per_page: 5},
    sort: %{sort_by: :item, sort_order: :asc}
  ]
  """
  def list_fires(criteria) when is_list(criteria) do
    query = from(f in Fire)

    Enum.reduce(criteria, query, fn
        {:paginate, %{page: page, per_page: per_page}}, query ->
          from q in query,
            offset: ^((page - 1) * per_page),
            limit: ^per_page
        {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
          from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end

  @doc """
  Returns a list of the most recent fire reports in the database.
  """
  def list_recent_fires(limit \\ 5) do
    from(r in Fire, order_by: [desc: r.updated_at], limit: ^limit)
    |> Repo.all()
  end

  @doc "Get total number of reports in the database"
  def get_total_fires() do
    from(f in Fire, select: count(f.id))
    |> Repo.one()
  end

  @doc """
  Returns a map of months and amount of measures
  """
  def list_category_counts do
    from(fire in Fire, group_by: fire.month, select: {fire.month, count(fire.id)})
    |> Repo.all()
    |> Enum.into(%{})
  end

  @doc """
  Gets a single fire.

  Raises `Ecto.NoResultsError` if the Fire does not exist.

  ## Examples

      iex> get_fire!(123)
      %Fire{}

      iex> get_fire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fire!(id), do: Repo.get!(Fire, id)

  @doc """
  Creates a fire.

  ## Examples

      iex> create_fire(%{field: value})
      {:ok, %Fire{}}

      iex> create_fire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fire(attrs \\ %{}) do
    %Fire{}
    |> Fire.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:created)
  end

  @doc """
  Updates a fire.

  ## Examples

      iex> update_fire(fire, %{field: new_value})
      {:ok, %Fire{}}

      iex> update_fire(fire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fire(%Fire{} = fire, attrs) do
    fire
    |> Fire.changeset(attrs)
    |> Repo.update()
    |> broadcast(:updated)
  end

  @doc """
  Deletes a fire.

  ## Examples

      iex> delete_fire(fire)
      {:ok, %Fire{}}

      iex> delete_fire(fire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fire(%Fire{} = fire) do
    Repo.delete(fire)
    |> broadcast(:deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fire changes.

  ## Examples

      iex> change_fire(fire)
      %Ecto.Changeset{data: %Fire{}}

  """
  def change_fire(%Fire{} = fire, attrs \\ %{}) do
    Fire.changeset(fire, attrs)
  end

  @doc """
  Expose subscription function for use in LiveViews
  """
  def subscribe do
    Phoenix.PubSub.subscribe(FireWatch.PubSub, "fires")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, fire}, event) do
    Phoenix.PubSub.broadcast(FireWatch.PubSub, "fires", {event, fire})
    {:ok, fire}
  end
end
