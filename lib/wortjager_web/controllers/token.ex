defmodule WortjagerWeb.Token do
  use WortjagerWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> render(WortjagerWeb.ErrorView, "error.json", error: "unauthenticated")
  end

  def unauthorized(conn, _params) do
    conn
    |> render(WortjagerWeb.ErrorView, "error.json", error: "unauthorized")
  end
end
