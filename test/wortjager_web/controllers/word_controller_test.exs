defmodule WortjagerWeb.WordControllerTest do
  use WortjagerWeb.ConnCase

  alias Wortjager.Dictionary
  alias Wortjager.Dictionary.Word

  @create_attrs %{content: "some content", props: "some props", translations: [], type: "some type"}
  @update_attrs %{content: "some updated content", props: "some updated props", translations: [], type: "some updated type"}
  @invalid_attrs %{content: nil, props: nil, translations: nil, type: nil}

  def fixture(:word) do
    {:ok, word} = Dictionary.create_word(@create_attrs)
    word
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all words", %{conn: conn} do
      conn = get conn, word_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create word" do
    test "renders word when data is valid", %{conn: conn} do
      conn = post conn, word_path(conn, :create), word: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, word_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some content",
        "props" => "some props",
        "translations" => [],
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, word_path(conn, :create), word: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update word" do
    setup [:create_word]

    test "renders word when data is valid", %{conn: conn, word: %Word{id: id} = word} do
      conn = put conn, word_path(conn, :update, word), word: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, word_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some updated content",
        "props" => "some updated props",
        "translations" => [],
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, word: word} do
      conn = put conn, word_path(conn, :update, word), word: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete word" do
    setup [:create_word]

    test "deletes chosen word", %{conn: conn, word: word} do
      conn = delete conn, word_path(conn, :delete, word)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, word_path(conn, :show, word)
      end
    end
  end

  defp create_word(_) do
    word = fixture(:word)
    {:ok, word: word}
  end
end
