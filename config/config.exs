# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fire_watch,
  ecto_repos: [FireWatch.Repo]

# Configures the endpoint
config :fire_watch, FireWatchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yd5IbYRz6UvxCsHGHrRNlP+/5Ws5euBBEH8loLV+A/gpunUHJvIdFC2k84fu6bkq",
  render_errors: [view: FireWatchWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FireWatch.PubSub,
  live_view: [signing_salt: "rYnbbhBo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
