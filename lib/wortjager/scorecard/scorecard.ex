defmodule Wortjager.Scorecard do
  @moduledoc """
  The Scorecard context.
  """

  import Ecto.Query, warn: false
  alias Wortjager.Repo

  alias Wortjager.Scorecard.Answer
  alias Wortjager.Dictionary
  
  @doc """
  Returns the list of answers.
  """
  def list_answers(%{id: user_id}) do
    query = from a in Answer,
      where: [user_id: ^user_id],
      select: a
    Repo.all(query)
  end

  @doc """
  Gets a single answer.
  """
  def get_answer!(id, %{id: user_id}) do
    query = from a in Answer,
      where: [id: ^id, user_id: ^user_id],
      limit: 1,
      select: a
    Repo.one!(query)
  end

  @doc """
  Creates a answer.
  """
  def create_answer(attrs \\ %{}) do
    word_id = attrs["word_id"]
    word = Dictionary.get_word!(word_id)
    result = check_answer(word, attrs)
    %Answer{}
    |> Answer.changeset(Map.put(attrs, "result", result))
    |> Repo.insert()
  end

  defp check_answer(%{props: props, translations: translations}, %{"response" => response, "type" => question_type}) do
    case question_type do
      "translation" -> Enum.member?(translations, response)
      _ -> props[question_type] == response
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.
  """
  def change_answer(%Answer{} = answer) do
    Answer.changeset(answer, %{})
  end
end
