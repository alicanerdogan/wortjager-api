defmodule WortjagerWeb.QuestionController do
  use WortjagerWeb, :controller

  alias Wortjager.Question

  action_fallback WortjagerWeb.FallbackController

  def get(conn, _params) do
    question = Question.get_question
    render(conn, "show.json", question: question)
  end
end
