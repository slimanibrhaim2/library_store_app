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
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs, user_scope) do
    book
    |> cast(attrs, [:title, :author, :description, :cover_url, :published_year, :isbn])
    |> validate_required([:title, :author, :description, :cover_url, :published_year, :isbn])
    |> put_change(:user_id, user_scope.user.id)
  end
end
