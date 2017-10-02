defmodule Wortjager.Repo.Migrations.AddAuthColumnsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :provider, :string
    end
  end
end
