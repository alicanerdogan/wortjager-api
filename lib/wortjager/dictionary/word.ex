defmodule Wortjager.Dictionary.Word do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wortjager.Dictionary.Word


  schema "words" do
    field :content, :string
    field :props, {:map, :string}
    field :translations, {:array, :string}
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Word{} = word, attrs) do
    word
    |> cast(attrs, [:type, :content, :translations, :props])
    |> validate_required([:type, :content, :translations])
    |> unique_constraint(:content)
  end
end
