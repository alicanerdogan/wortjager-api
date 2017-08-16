defmodule Wortjager.ScorecardTest do
  use Wortjager.DataCase

  alias Wortjager.Scorecard

  describe "answers" do
    alias Wortjager.Scorecard.Answer

    @valid_attrs %{response: "some response", type: "some type", user_id: 42, word_id: 42}
    @update_attrs %{response: "some updated response", type: "some updated type", user_id: 43, word_id: 43}
    @invalid_attrs %{response: nil, type: nil, user_id: nil, word_id: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scorecard.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Scorecard.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Scorecard.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Scorecard.create_answer(@valid_attrs)
      assert answer.response == "some response"
      assert answer.type == "some type"
      assert answer.user_id == 42
      assert answer.word_id == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, answer} = Scorecard.update_answer(answer, @update_attrs)
      assert %Answer{} = answer
      assert answer.response == "some updated response"
      assert answer.type == "some updated type"
      assert answer.user_id == 43
      assert answer.word_id == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Scorecard.update_answer(answer, @invalid_attrs)
      assert answer == Scorecard.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Scorecard.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Scorecard.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Scorecard.change_answer(answer)
    end
  end
end
