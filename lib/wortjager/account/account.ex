defmodule Wortjager.Account do
  import Ecto.Query, warn: false
  alias Wortjager.Repo

  alias Wortjager.Account.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  """
  def get_user!(id), do: Repo.get!(User, id)
  
  @doc """
  Gets a single user.
  """
  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
  
  @doc """
  Creates a user with provider credentials.
  """
  def create_user_with_provider(attrs \\ %{}) do
    %User{}
    |> User.provider_registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates an admin.
  """
  def create_admin(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(Map.put(attrs, :role, User.roles[:admin]))
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user) do
    User.registration_changeset(user, %{})
  end
end
