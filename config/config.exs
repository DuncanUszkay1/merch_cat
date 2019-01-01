# General application configuration
use Mix.Config

config :merch_cat,
  ecto_repos: [MerchCat.Repo]

# Configures the endpoint
config :merch_cat, MerchCatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "we-dont-use-this",
  render_errors: [view: MerchCatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MerchCat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Discord bot config
config :nostrum,
  token: System.get_env("DISCORD_BOT_TOKEN"),
  num_shards: :auto
