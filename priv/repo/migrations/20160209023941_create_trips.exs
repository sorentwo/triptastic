defmodule Triptastic.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :name, :string
      add :category, :string
      add :favorites, :integer, default: 0
    end
  end
end
