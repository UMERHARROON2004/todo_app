defmodule TodoApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :status, :string, default: "pending", null: false

      timestamps() # Automatically adds inserted_at and updated_at
    end
  end
end

