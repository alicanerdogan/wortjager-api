defmodule WortjagerWeb.SessionController do
  use WortjagerWeb, :controller
  alias WortjagerWeb.Token

  def create(conn, %{"email" => email, "password" => password}) do
      case WortjagerWeb.Auth.login_by_email_and_pass(conn, email, password) do
          {:ok, conn} ->
              logged_in_user = Guardian.Plug.current_resource(conn)
              { new_conn, jwt, exp } = Token.generate(conn, logged_in_user)
              render(new_conn, SessionView, "login.json", user: logged_in_user, jwt: jwt, exp: exp)
          {:error, reason, conn} ->
              conn
              |> put_status(:unprocessable_entity)
              |> render(WortjagerWeb.ChangesetView, "error.json", changeset: reason)
      end
  end

  def logout(conn, _params) do
      jwt = Guardian.Plug.current_token(conn)
      {_, claims} = Guardian.Plug.claims(conn)
      Guardian.revoke!(jwt, claims)
      send_resp(conn, :no_content, "")
  end
end
