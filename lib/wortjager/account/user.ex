defmodule Wortjager.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wortjager.Account.User
  alias Wortjager.Scorecard.Answer

  schema "users" do
    has_many :answers, Answer
    field :email, :string
    field :password, :string, virtual: true
    field :role, :string
    field :password_hash, :string

    timestamps()
  end

  @defined_roles %{admin: "admin"};
  def roles, do: @defined_roles

  @doc false
  defp changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :role])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
  end

  def registration_changeset(model, attrs) do
    model
    |> changeset(attrs)
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
