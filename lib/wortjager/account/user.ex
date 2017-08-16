defmodule Wortjager.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wortjager.Account.User
  alias Wortjager.Scorecard.Answer

  schema "users" do
    has_many :answers, Answer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  defp changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
  end

  def registration_changeset(model, attrs) do
    model
    |> changeset(attrs)
    |> validate_length(:password, min: 6)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
