use Mix.Config

config :cover, ecto_repos: [Cover.Repo]

import_config "#{Mix.env}.exs"
