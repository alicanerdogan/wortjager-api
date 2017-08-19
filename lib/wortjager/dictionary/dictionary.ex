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
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a word.
  """
  def create_words(attrs \\ [%{}]) do
    words = attrs
      |> Enum.map(&create_word/1)
      |> Enum.filter(fn(result_word_pair) -> elem(result_word_pair, 0) == :ok end)
      |> Enum.map(fn(result_word_pair) -> elem(result_word_pair, 1) end)
    {:ok, words}
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

  def get_ids() do
    query = from w in Word,
      select: w.id
    Repo.all(query)
  end
end
