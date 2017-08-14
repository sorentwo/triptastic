defmodule Triptastic.TripBenchmarkTest do
  use ExUnit.Case

  alias Triptastic.{Repo, Trip}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  def ms(parent, fun) do
    Task.async(fn ->
      Ecto.Adapters.SQL.Sandbox.allow(Repo, parent, self())
      begin = :os.timestamp
      fun.()
      finish = :os.timestamp
      :timer.now_diff(finish, begin) / 1000
    end) |> Task.await
  end

  for num <- [100, 500, 5_000, 10_000, 20_000] do
    @tag num: num
    test "compare memory and windows for #{num} trips", %{num: num} do
      categories = Stream.cycle(Trip.categories)

      trips = for _ <- 1..num do
        cat = hd(Enum.take(categories, 1))
        fav = trunc(:rand.uniform() * 10)

        %{name: "#{cat}-#{fav}", category: cat, favorites: fav}
      end

      Repo.insert_all(Trip, trips)

      mem = ms(self(), fn -> Trip |> Repo.all |> Trip.popular_by_category end)
      win = ms(self(), fn -> Trip.popular_over_category end))
      wij = ms(self(), fn -> Trip.popular_over_category_joined |> Repo.all end)

      IO.puts "| #{num} | #{mem} | #{win} | #{wij} |"
    end
  end
end
