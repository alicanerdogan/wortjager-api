defmodule WortjagerWeb.AnswerView do
  use WortjagerWeb, :view
  alias WortjagerWeb.AnswerView

  def render("index.json", %{answers: answers}) do
    render_many(answers, AnswerView, "answer.json")
  end

  def render("show.json", %{answer: answer}) do
    render_one(answer, AnswerView, "answer.json")
  end

  def render("answer.json", %{answer: answer}) do
    %{id: answer.id,
      response: answer.response,
      word_id: answer.word_id,
      user_id: answer.user_id,
      type: answer.type,
      result: answer.result}
  end
end
