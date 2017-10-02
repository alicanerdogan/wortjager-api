defmodule WortjagerWeb.GoogleAuthController do
  use WortjagerWeb, :controller
  alias Wortjager.Account
  alias WortjagerWeb.SessionView
  alias WortjagerWeb.Token

  action_fallback WortjagerWeb.FallbackController

  def authorize(conn, %{"code" => not_verified_code}) do
    case get_user_mail(not_verified_code) do
      {:ok, email} ->
        user = Account.get_user_by_email(email) || Account.create_user_with_provider(%{ email: email, provider: "google" })
        render_token_response(conn, user)
      error ->
        IO.inspect error
        conn |> send_resp(400, "User mail not provided")
    end
  end

  defp render_token_response(conn, user) do
    { new_conn, jwt, exp } = Token.generate(conn, user)
    render(new_conn, SessionView, "login.json", user: user, jwt: jwt, exp: exp)
  end

  defp get_user_mail(not_verified_code) do
    case get_user_token(not_verified_code) do
      {:ok, %{"id_token" => id_token}} ->
        [ _ | [ content | _ ] ] = String.split(id_token, ".")
        { _ , content } = Base.decode64(content, padding: false)
        { _ , %{ "email" => email } } = Poison.decode(content)
        { :ok, email }
      error -> error
    end
  end

  defp get_user_token(not_verified_code) do
    [google: [client_id: client_id, redirect_uri_path: redirect_uri, grant_type: grant_type, post_url: post_url, client_secret: client_secret]] = Application.get_env(:wortjager, :auth)
    body = "code=#{not_verified_code}&client_id=#{client_id}&client_secret=#{client_secret}&grant_type=#{grant_type}&redirect_uri=#{redirect_uri}"
    case HTTPoison.post(post_url, body, [{"Content-Type", "application/x-www-form-urlencoded"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
      result -> result
    end
  end
end
