defmodule LibraryStoreAppWeb.BookLive.Show do
  use LibraryStoreAppWeb, :live_view

  alias LibraryStoreApp.Library

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <.link navigate={~p"/books"} class="btn btn-ghost btn-sm mb-4">
          <.icon name="hero-arrow-left" class="w-4 h-4 mr-2" /> Back to Books
        </.link>

        <div class="card lg:card-side bg-base-200 shadow-xl">
          <figure class="lg:w-1/3 p-8">
            <img
              src={@book.cover_url}
              alt={@book.title}
              class="rounded-lg max-h-96 object-contain bg-white"
            />
          </figure>
          <div class="card-body lg:w-2/3">
            <div class="flex justify-between items-start">
              <div class="flex-1">
                <h1 class="card-title text-3xl mb-2">{@book.title}</h1>
                <p class="text-lg text-base-content/80 mb-2">by {@book.author}</p>
                <p class="text-sm text-base-content/60 mb-4">
                  Published: {@book.published_year} | ISBN: {@book.isbn}
                </p>
              </div>

              <button
                phx-click="toggle_favorite"
                class={[
                  "btn btn-lg btn-circle",
                  if(@is_favorited, do: "btn-error", else: "btn-ghost")
                ]}
                title={if @is_favorited, do: "Remove from favorites", else: "Add to favorites"}
              >
                <.icon
                  name={if @is_favorited, do: "hero-heart-solid", else: "hero-heart"}
                  class="w-8 h-8"
                />
              </button>
            </div>

            <div class="divider"></div>

            <div>
              <h2 class="text-xl font-semibold mb-3">Description</h2>
              <p class="text-base-content/80 leading-relaxed">{@book.description}</p>
            </div>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    user_id = socket.assigns.current_scope.user.id
    book_data = Library.get_book_with_favorite(id, user_id)

    if book_data do
      {:ok,
       assign(socket,
         book: book_data.book,
         is_favorited: book_data.is_favorited,
         page_title: book_data.book.title
       )}
    else
      {:ok,
       socket
       |> put_flash(:error, "Book not found")
       |> push_navigate(to: ~p"/books")}
    end
  end

  @impl true
  def handle_event("toggle_favorite", _params, socket) do
    user_id = socket.assigns.current_scope.user.id
    book_id = socket.assigns.book.id

    Library.toggle_favorite(user_id, book_id)

    # Reload book with updated favorite status
    book_data = Library.get_book_with_favorite(book_id, user_id)

    {:noreply, assign(socket, is_favorited: book_data.is_favorited)}
  end
end
