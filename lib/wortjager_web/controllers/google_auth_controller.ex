defmodule WortjagerWeb.GoogleAuthController do
  use WortjagerWeb, :controller
  alias Wortjager.Account
  alias WortjagerWeb.SessionView
  alias WortjagerWeb.Token

  action_fallback WortjagerWeb.FallbackController

  def authorize(conn, %{"code" => not_verified_code}) do
    case get_user_mail(conn, not_verified_code) do
      {:ok, email} ->
        case Account.get_user_by_email!(email) do
          user ->
            { new_conn, jwt, exp } = Token.generate(conn, user)
            render(new_conn, SessionView, "login.json", user: user, jwt: jwt, exp: exp)
          _ ->
            conn |> send_resp(400, "User not found!")
        end
      other ->
        IO.inspect other
        conn |> send_resp(400, "User mail not provided")
    end
  end

  defp get_user_mail(conn, not_verified_code) do
    case get_user_token(conn, not_verified_code) do
      {:ok, %{"id_token" => id_token}} ->
        [ _ | [ content | _ ] ] = String.split(id_token, ".")
        { _ , content } = Base.decode64(content, padding: false)
        { _ , %{ "email" => email } } = Poison.decode(content)
        { :ok, email }
      _ ->
        :error
    end
  end

  defp get_user_token(conn, not_verified_code) do
    [google: [client_id: client_id, redirect_uri_path: redirect_uri, grant_type: grant_type, post_url: post_url, client_secret: client_secret]] = Application.get_env(:wortjager, :auth)
    body = "code=#{not_verified_code}&client_id=#{client_id}&client_secret=#{client_secret}&grant_type=#{grant_type}&redirect_uri=#{redirect_uri}"
    case HTTPoison.post(post_url, body, [{"Content-Type", "application/x-www-form-urlencoded"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
      other ->
        IO.inspect other
        {:fail}
    end
  end
end
