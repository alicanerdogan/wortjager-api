defmodule WortjagerWeb.StatisticsView do
  use WortjagerWeb, :view
  alias WortjagerWeb.StatisticsView

  def render("show.json", %{statistics: statistics}) do
    render_one(statistics, StatisticsView, "statistics.json")
  end

  def render("statistics.json", %{statistics: statistics}), do: statistics
end
