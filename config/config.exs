# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sentinel_api,
  ecto_repos: [SentinelApi.Repo]

# Configures the endpoint
config :sentinel_api, SentinelApi.Endpoint,
       url: [host: "localhost"],
       secret_key_base: "your_secret_keyyour_secret_keyyour_secret_keyyour_secret_keyyour_secret_keyyour_secret_key",
       render_errors: [view: SentinelApi.ErrorView, accepts: ~w(html json)],
       pubsub: [name: SentinelApi.PubSub,
                adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  issuer: "SentinelApi",
  ttl: { 3, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: {SentinelApi.SecretKey, :fetch},
  serializer: SentinelApi.GuardianSerializer

config :sentinel_api, SentinelApi.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.domain",
  port: 1025,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
