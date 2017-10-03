defmodule Wortjager.Question do
  import Ecto.Query, warn: false

  alias Wortjager.Dictionary

  @doc """
  Gets a question.
  """
  def get_question() do
    Dictionary.get_ids
    |> Enum.random
    |> Dictionary.get_word!
    |> create_question
  end

  @question_types %{
    noun: ["artikel", "translation", "plural"],
    verb: ["preterite", "translation", "pp"],
    adjective: ["translation"],
    adverb: ["translation"],
    conjugation: ["translation"]
  }

  defp create_question(word) do
    question_type = Enum.random(@question_types[String.to_atom(word.type)])
    Map.put(word, :question_type, question_type)
  end
end
