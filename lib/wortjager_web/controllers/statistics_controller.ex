defmodule WortjagerWeb.StatisticsController do
  use WortjagerWeb, :controller

  alias Wortjager.Statistics

  action_fallback WortjagerWeb.FallbackController

  def get(conn, _params) do
    statistics = Guardian.Plug.current_resource(conn)
    |> Statistics.get_statistics
    render(conn, "show.json", statistics: statistics)
  end
end
