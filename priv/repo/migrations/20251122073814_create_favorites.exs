defmodule LibraryStoreApp.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :book_id, references(:books, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:favorites, [:user_id])
    create index(:favorites, [:book_id])
    create unique_index(:favorites, [:user_id, :book_id])
  end
end
