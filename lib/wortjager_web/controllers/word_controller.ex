defmodule WortjagerWeb.WordController do
  use WortjagerWeb, :controller

  alias Wortjager.Dictionary
  alias Wortjager.Dictionary.Word

  action_fallback WortjagerWeb.FallbackController

  def index(conn, _params) do
    words = Dictionary.list_words()
    render(conn, "index.json", words: words)
  end

  def create(conn, word_params) do
    with {:ok, %Word{} = word} <- Dictionary.create_word(word_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", word_path(conn, :show, word))
      |> render("show.json", word: word)
    end
  end

  def show(conn, %{"id" => id}) do
    word = Dictionary.get_word!(id)
    render(conn, "show.json", word: word)
  end

  def update(conn, %{"id" => id, "word" => word_params}) do
    word = Dictionary.get_word!(id)

    with {:ok, %Word{} = word} <- Dictionary.update_word(word, word_params) do
      render(conn, "show.json", word: word)
    end
  end

  def delete(conn, %{"id" => id}) do
    word = Dictionary.get_word!(id)
    with {:ok, %Word{}} <- Dictionary.delete_word(word) do
      send_resp(conn, :no_content, "")
    end
  end
end
