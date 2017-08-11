defmodule WortjagerWeb.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Wortjager.Account
  alias Wortjager.Account.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Account.get_user!(id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
