defmodule WortjagerWeb.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  alias Wortjager.Account
  alias Wortjager.Account.User

  def login(conn, user) do
      conn
      |> fetch_session
      |> Guardian.Plug.sign_in(user, :access)
  end

  def login_by_email_and_pass(conn, email, password) do
      user = Account.get_user_by_email!(email)
      cond do
          user && checkpw(password, user.password_hash) ->
              {:ok, login(conn, user)}
          user ->
              {:error, :unauthorized, conn}
          true ->
              dummy_checkpw()
              {:error, :not_found, conn}
      end
  end
end
