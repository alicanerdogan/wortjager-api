defmodule WortjagerWeb.AnswerControllerTest do
  use WortjagerWeb.ConnCase

  alias Wortjager.Scorecard
  alias Wortjager.Scorecard.Answer

  @create_attrs %{response: "some response", type: "some type", user_id: 42, word_id: 42}
  @update_attrs %{response: "some updated response", type: "some updated type", user_id: 43, word_id: 43}
  @invalid_attrs %{response: nil, type: nil, user_id: nil, word_id: nil}

  def fixture(:answer) do
    {:ok, answer} = Scorecard.create_answer(@create_attrs)
    answer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all answers", %{conn: conn} do
      conn = get conn, answer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create answer" do
    test "renders answer when data is valid", %{conn: conn} do
      conn = post conn, answer_path(conn, :create), answer: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, answer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "response" => "some response",
        "type" => "some type",
        "user_id" => 42,
        "word_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, answer_path(conn, :create), answer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update answer" do
    setup [:create_answer]

    test "renders answer when data is valid", %{conn: conn, answer: %Answer{id: id} = answer} do
      conn = put conn, answer_path(conn, :update, answer), answer: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, answer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "response" => "some updated response",
        "type" => "some updated type",
        "user_id" => 43,
        "word_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, answer: answer} do
      conn = put conn, answer_path(conn, :update, answer), answer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete answer" do
    setup [:create_answer]

    test "deletes chosen answer", %{conn: conn, answer: answer} do
      conn = delete conn, answer_path(conn, :delete, answer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, answer_path(conn, :show, answer)
      end
    end
  end

  defp create_answer(_) do
    answer = fixture(:answer)
    {:ok, answer: answer}
  end
end
