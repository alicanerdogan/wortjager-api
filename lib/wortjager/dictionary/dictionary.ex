defmodule Wortjager.Dictionary do
  @moduledoc """
  The Dictionary context.
  """

  import Ecto.Query, warn: false
  alias Wortjager.Repo

  alias Wortjager.Dictionary.Word

  @doc """
  Returns the list of words.
  """
  def list_words do
    Repo.all(Word)
  end

  @doc """
  Gets a single word.
  """
  def get_word!(id), do: Repo.get!(Word, id)

  @doc """
  Creates a word.
  """
  def create_word(attrs \\ %{}) do
    IO.inspect attrs
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a word.
  """
  def update_word(%Word{} = word, attrs) do
    word
    |> Word.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Word.
  """
  def delete_word(%Word{} = word) do
    Repo.delete(word)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking word changes.
  """
  def change_word(%Word{} = word) do
    Word.changeset(word, %{})
  end
end
