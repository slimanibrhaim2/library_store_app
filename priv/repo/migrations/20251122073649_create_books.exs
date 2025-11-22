defmodule LibraryStoreApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :description, :text
      add :cover_url, :string
      add :published_year, :integer
      add :isbn, :string
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:books, [:user_id])
  end
end
