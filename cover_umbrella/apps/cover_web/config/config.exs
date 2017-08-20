# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cover_web,
  namespace: CoverWeb,
  ecto_repos: [Cover.Repo]

# Configures the endpoint
config :cover_web, CoverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wxoLgexMoM76S5VwcrbcZZRdsJTNEfqYV/1M8qUcfMISOXB1fhbyIIIeO8pBp1i6",
  render_errors: [view: CoverWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CoverWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cover_web, :generators,
  context_app: :cover

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
