defmodule Wortjager.Repo.Migrations.AddContentAsUnique do
  use Ecto.Migration

  def change do
    create unique_index(:words, [:content])
  end
end
