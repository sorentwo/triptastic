defmodule Triptastic.TripBenchmarkTest do
  use ExUnit.Case

  alias Triptastic.{Repo, Trip}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Triptastic.Repo)
  end

  def ms(fun) do
    begin = :os.timestamp
    fun.()
    finish = :os.timestamp
    :timer.now_diff(finish, begin) / 1000
  end

  def build(category, favorites) do
    %{name: "#{category}-#{favorites}",
      category: category,
      favorites: favorites}
  end

  for num <- [100, 500, 5_000, 10_000, 20_000] do
    @tag num: num
    test "compare memory and windows for #{num} trips", %{num: num} do
      categories = Stream.cycle(Trip.categories)

      favorites = fn -> trunc(:rand.uniform() * 10) end
      category = fn -> hd(Enum.take(categories, 1)) end
      trips = for _ <- 1..num, do: build(category.(), favorites.())

      Repo.insert_all(Trip, trips)

      mem = ms(fn -> Trip |> Repo.all |> Trip.popular_by_category end)
      win = ms(fn -> Trip.popular_over_category end)
      wij = ms(fn -> Trip.popular_over_category_joined |> Repo.all end)

      IO.puts "num: #{num} | mem: #{mem} | win: #{win} | wij: #{wij}"
    end
  end
end
