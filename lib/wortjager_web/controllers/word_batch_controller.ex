defmodule WortjagerWeb.WordBatchController do
  use WortjagerWeb, :controller

  alias Wortjager.Dictionary
  alias WortjagerWeb.WordView

  # action_fallback WortjagerWeb.FallbackController

  def create(conn, %{"_json" => word_params}) do
    case Guardian.Plug.current_resource(conn) do
      %{role: "admin"} ->
        with {:ok, words} <- Dictionary.create_words(word_params) do
          conn
          |> put_status(:created)
          |> render(WordView, "index.json", words: words)
        end
      _ -> conn |> put_status(:unauthorized)
    end
  end
end
