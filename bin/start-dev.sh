cd /root/apps &&
mix local.hex --force &&
mix deps.get &&
mix local.rebar --force &&
mix compile &&
mix ecto.create &&
mix ecto.migrate &&
mix phx.server
