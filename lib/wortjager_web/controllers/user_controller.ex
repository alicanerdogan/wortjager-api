defmodule WortjagerWeb.UserController do
  use WortjagerWeb, :controller

  alias Wortjager.Account
  alias Wortjager.Account.User
  alias WortjagerWeb.SessionView
  alias WortjagerWeb.Token

  action_fallback WortjagerWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      { new_conn, jwt, exp } = Token.generate(conn, user)
      render(new_conn, SessionView, "login.json", user: user, jwt: jwt, exp: exp)
    end
  end

  def show(conn, _params) do
    logged_in_user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: logged_in_user)
  end

  def update(conn, user_params) do
    logged_in_user = Guardian.Plug.current_resource(conn)
    with {:ok, %User{} = user} <- Account.update_user(logged_in_user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _params) do
    logged_in_user = Guardian.Plug.current_resource(conn)
    with {:ok, %User{}} <- Account.delete_user(logged_in_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
