defmodule LibraryStoreApp.Library.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    belongs_to :user, LibraryStoreApp.Accounts.User
    belongs_to :book, LibraryStoreApp.Library.Book

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :book_id])
    |> validate_required([:user_id, :book_id])
    |> unique_constraint([:user_id, :book_id], name: :favorites_user_id_book_id_index)
  end
end
