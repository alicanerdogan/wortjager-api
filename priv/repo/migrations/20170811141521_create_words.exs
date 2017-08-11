defmodule Wortjager.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :type, :string
      add :content, :string
      add :translations, {:array, :string}
      add :props, {:map, :string}

      timestamps()
    end

  end
end
