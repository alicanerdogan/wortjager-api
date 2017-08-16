defmodule Wortjager.Repo.Migrations.AddResultColumn do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :result, :boolean
    end

  end
end
