defmodule WortjagerWeb.Token do
  use WortjagerWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> render(WortjagerWeb.ErrorView, "error.json", error: "unauthenticated")
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(WortjagerWeb.ErrorView, "error.json", error: "unauthorized")
  end

  def generate(conn, user) do
    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {_, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn = new_conn
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> put_resp_header("x-expires", Integer.to_string(exp))

    { new_conn, jwt, exp }
  end
end
