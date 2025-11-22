defmodule LibraryStoreApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :description, :string
    field :cover_url, :string
    field :published_year, :integer
    field :isbn, :string

    many_to_many :favorited_by, LibraryStoreApp.Accounts.User,
      join_through: LibraryStoreApp.Library.Favorite

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :description, :cover_url, :published_year, :isbn])
    |> validate_required([:title, :author])
  end
end
