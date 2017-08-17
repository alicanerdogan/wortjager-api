defmodule WortjagerWeb.QuestionView do
  use WortjagerWeb, :view
  alias WortjagerWeb.QuestionView

  def render("show.json", %{question: question}) do
    render_one(question, QuestionView, "question.json")
  end

  def render("question.json", %{question: question}) do
    %{word_id: question.id,
      type: question.type,
      content: question.content,
      translations: question.translations,
      props: question.props,
      question_type: question.question_type}
  end
end
