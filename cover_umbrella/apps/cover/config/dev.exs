use Mix.Config

# Configure your database
config :cover, Cover.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cover_dev",
  hostname: "localhost",
  pool_size: 10
