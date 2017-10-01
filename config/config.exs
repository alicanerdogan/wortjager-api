# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wortjager,
  ecto_repos: [Wortjager.Repo]

# Configures the endpoint
config :wortjager, WortjagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "w+LNocg3KMezZYLjl/ZSp5tlGKMglA0OHYlyqXuanlzT2NdbzPJGT+JW93ee8hXC",
  render_errors: [view: WortjagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wortjager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Wortjager",
  ttl: { 7, :days},
  verify_issuer: true,
  secret_key: "ABOVBUDAOLMAZARTIK",
  serializer: WortjagerWeb.GuardianSerializer

config :wortjager, :auth,
  google: [ client_id: "891278828941-48vpaqffj33orudas47ug1erfqo38vir.apps.googleusercontent.com",
            redirect_uri_path: "/auth/google",
            grant_type: "authorization_code",
            post_url: "https://accounts.google.com/o/oauth2/token" ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "common.secret.exs"
import_config "#{Mix.env}.exs"
