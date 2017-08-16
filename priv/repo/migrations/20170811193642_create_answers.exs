defmodule Wortjager.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :response, :string
      add :word_id, :integer
      add :user_id, :integer
      add :type, :string

      timestamps()
    end

  end
end
