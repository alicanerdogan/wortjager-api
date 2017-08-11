defmodule Wortjager.DictionaryTest do
  use Wortjager.DataCase

  alias Wortjager.Dictionary

  describe "words" do
    alias Wortjager.Dictionary.Word

    @valid_attrs %{content: "some content", props: "some props", translations: [], type: "some type"}
    @update_attrs %{content: "some updated content", props: "some updated props", translations: [], type: "some updated type"}
    @invalid_attrs %{content: nil, props: nil, translations: nil, type: nil}

    def word_fixture(attrs \\ %{}) do
      {:ok, word} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dictionary.create_word()

      word
    end

    test "list_words/0 returns all words" do
      word = word_fixture()
      assert Dictionary.list_words() == [word]
    end

    test "get_word!/1 returns the word with given id" do
      word = word_fixture()
      assert Dictionary.get_word!(word.id) == word
    end

    test "create_word/1 with valid data creates a word" do
      assert {:ok, %Word{} = word} = Dictionary.create_word(@valid_attrs)
      assert word.content == "some content"
      assert word.props == "some props"
      assert word.translations == []
      assert word.type == "some type"
    end

    test "create_word/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_word(@invalid_attrs)
    end

    test "update_word/2 with valid data updates the word" do
      word = word_fixture()
      assert {:ok, word} = Dictionary.update_word(word, @update_attrs)
      assert %Word{} = word
      assert word.content == "some updated content"
      assert word.props == "some updated props"
      assert word.translations == []
      assert word.type == "some updated type"
    end

    test "update_word/2 with invalid data returns error changeset" do
      word = word_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_word(word, @invalid_attrs)
      assert word == Dictionary.get_word!(word.id)
    end

    test "delete_word/1 deletes the word" do
      word = word_fixture()
      assert {:ok, %Word{}} = Dictionary.delete_word(word)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_word!(word.id) end
    end

    test "change_word/1 returns a word changeset" do
      word = word_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_word(word)
    end
  end
end
