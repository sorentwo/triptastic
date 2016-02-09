defmodule Triptastic.TripRepoTest do
  use ExUnit.Case

  alias Triptastic.{Repo, Trip}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Triptastic.Repo)

    trips = for category <- Trip.categories, favorites <- 0..5 do
      %{name: "#{category}-#{favorites}",
        category: category,
        favorites: favorites}
    end

    Repo.insert_all(Trip, trips)

    :ok
  end

  test "grouping top trips by category in memory" do
    trips = Repo.all(Trip) |> Trip.popular_by_category()

    assert length(trips) == 8
    assert Enum.all?(trips, &(&1.favorites > 2))
  end

  test "grouping top trips by category using windows" do
    {:ok, result} = Trip.popular_over_category()

    assert result.num_rows == 8
    assert Enum.all?(result.rows, &(Enum.at(&1, 3) >= 2))
  end
end
