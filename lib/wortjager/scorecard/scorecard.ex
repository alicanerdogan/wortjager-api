defmodule Wortjager.Scorecard do
  @moduledoc """
  The Scorecard context.
  """

  import Ecto.Query, warn: false
  alias Wortjager.Repo

  alias Wortjager.Scorecard.Answer

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
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.
  """
  def change_answer(%Answer{} = answer) do
    Answer.changeset(answer, %{})
  end
end
