defmodule WortjagerWeb.SessionController do
  use WortjagerWeb, :controller

  def create(conn, %{"email" => email, "password" => password}) do
      case WortjagerWeb.Auth.login_by_email_and_pass(conn, email, password) do
          {:ok, conn} ->
              logged_in_user = Guardian.Plug.current_resource(conn)
              new_conn = Guardian.Plug.api_sign_in(conn, logged_in_user)
              jwt = Guardian.Plug.current_token(new_conn)
              {_, claims} = Guardian.Plug.claims(new_conn)
              exp = Map.get(claims, "exp")

              new_conn
              |> put_resp_header("authorization", "Bearer #{jwt}")
              |> put_resp_header("x-expires", Integer.to_string(exp))
              |> render("login.json", user: logged_in_user, jwt: jwt, exp: exp)
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
