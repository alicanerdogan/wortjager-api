defmodule Wortjager.Scorecard.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wortjager.Scorecard.Answer
  alias Wortjager.Dictionary.Word

  schema "answers" do
    has_one :word, Word
    field :response, :string
    field :type, :string
    field :user_id, :integer
    field :word_id, :integer
    field :result, :boolean

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:response, :word_id, :user_id, :type, :result])
    |> validate_required([:response, :word_id, :user_id, :type, :result])
  end
end
