defmodule LibraryStoreApp.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias LibraryStoreApp.Repo

  alias LibraryStoreApp.Library.Book
  alias LibraryStoreApp.Library.Favorite

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Returns the list of books with favorite status for a given user.
  """
  def list_books_with_favorites(user_id) do
    from(b in Book,
      left_join: f in Favorite,
      on: f.book_id == b.id and f.user_id == ^user_id,
      select: %{book: b, is_favorited: not is_nil(f.id)}
    )
    |> Repo.all()
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Gets a single book with favorite status for a user.
  """
  def get_book_with_favorite(id, user_id) do
    from(b in Book,
      left_join: f in Favorite,
      on: f.book_id == b.id and f.user_id == ^user_id,
      where: b.id == ^id,
      select: %{book: b, is_favorited: not is_nil(f.id)}
    )
    |> Repo.one()
  end

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Toggles a book as favorite for a user.
  If already favorited, removes the favorite. Otherwise, adds it.
  """
  def toggle_favorite(user_id, book_id) do
    case Repo.get_by(Favorite, user_id: user_id, book_id: book_id) do
      nil ->
        # Add favorite
        %Favorite{}
        |> Favorite.changeset(%{user_id: user_id, book_id: book_id})
        |> Repo.insert()

      favorite ->
        # Remove favorite
        Repo.delete(favorite)
    end
  end

  @doc """
  Returns the list of favorite books for a user.
  """
  def list_favorite_books(user_id) do
    from(b in Book,
      join: f in Favorite,
      on: f.book_id == b.id,
      where: f.user_id == ^user_id,
      select: b
    )
    |> Repo.all()
  end
end
