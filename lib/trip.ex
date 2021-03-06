defmodule Triptastic.Trip do
  use Ecto.Schema

  import Ecto.Query, only: [from: 2]

  @categories ~w(golf tennis badminton pickleball)

  schema "trips" do
    field :name, :string
    field :category, :string
    field :favorites, :integer, default: 0
  end

  def categories, do: @categories

  def popular_by_category(trips, per \\ 2) do
    trips
    |> Enum.group_by(&(&1.category))
    |> Enum.flat_map(&(popular_in_subset(&1, per)))
  end

  defp popular_in_subset({_category, trips}, per) do
    trips
    |> Enum.sort_by(&([-&1.favorites, &1.name]))
    |> Enum.take(per)
  end

  def popular_over_category(per \\ 2) do
    query = """
      SELECT * FROM (SELECT *, row_number() OVER (
        PARTITION BY category
        ORDER BY favorites DESC, name ASC
      ) FROM trips) AS t WHERE t.row_number <= $1::integer;
    """

    Ecto.Adapters.SQL.query(Triptastic.Repo, query, [per])
  end

  def popular_over_category_joined(per \\ 2) do
    from t in __MODULE__,
      join: p in fragment("""
        SELECT *, row_number() OVER (
          PARTITION BY category
          ORDER BY favorites DESC, name ASC
        ) FROM trips
      """),
      where: p.row_number <= ^per and p.id == t.id
  end
end
