defmodule WortjagerWeb.WordView do
  use WortjagerWeb, :view
  alias WortjagerWeb.WordView

  def render("index.json", %{words: words}) do
    %{data: render_many(words, WordView, "word.json")}
  end

  def render("show.json", %{word: word}) do
    %{data: render_one(word, WordView, "word.json")}
  end

  def render("word.json", %{word: word}) do
    %{id: word.id,
      type: word.type,
      content: word.content,
      translations: word.translations,
      props: word.props}
  end
end
