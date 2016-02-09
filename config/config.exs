use Mix.Config

config :logger, level: :warn

config :triptastic, Triptastic.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "triptastic_dev",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
