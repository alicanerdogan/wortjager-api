defmodule WortjagerWeb.AnswerController do
  use WortjagerWeb, :controller

  alias Wortjager.Scorecard
  alias Wortjager.Scorecard.Answer

  action_fallback WortjagerWeb.FallbackController

  def index(conn, _params) do
    logged_in_user = Guardian.Plug.current_resource(conn)
    answers = Scorecard.list_answers(logged_in_user)
    render(conn, "index.json", answers: answers)
  end

  def create(conn, answer_params) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)
    with {:ok, %Answer{} = answer} <- Scorecard.create_answer(Map.put(answer_params, "user_id", user_id)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", answer_path(conn, :show, answer))
      |> render("show.json", answer: answer)
    end
  end

  def show(conn, %{"id" => id}) do
    logged_in_user = Guardian.Plug.current_resource(conn)
    answer = Scorecard.get_answer!(id, logged_in_user)
    render(conn, "show.json", answer: answer)
  end
end
