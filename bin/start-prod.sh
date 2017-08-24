cd /root/apps &&
mix local.hex --force &&
mix deps.get --only prod &&
mix local.rebar --force &&
MIX_ENV=prod mix compile &&
MIX_ENV=prod mix ecto.create &&
MIX_ENV=prod mix ecto.migrate &&
PORT=4000 MIX_ENV=prod mix phx.server
