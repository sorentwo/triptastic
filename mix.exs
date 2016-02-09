defmodule Triptastic.Mixfile do
  use Mix.Project

  def project do
    [app: :triptastic,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [mod: {Triptastic.App, []},
     applications: [:logger, :ecto, :postgrex]]
  end

  defp deps do
    [{:ecto, github: "elixir-lang/ecto"},
     {:postgrex, "~> 0.11"}]
  end
end
