defmodule LibraryStoreAppWeb.BookLive.Index do
  use LibraryStoreAppWeb, :live_view

  alias LibraryStoreApp.Library

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mb-8">
          <h1 class="text-4xl font-bold mb-2">Library Store</h1>
          <p class="text-base-content/70">Browse our collection of programming books</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          <div :for={item <- @books} class="card bg-base-200 shadow-xl hover:shadow-2xl transition-shadow">
            <figure class="px-4 pt-4">
              <img
                src={item.book.cover_url}
                alt={item.book.title}
                class="rounded-lg h-64 w-full object-contain bg-white"
              />
            </figure>
            <div class="card-body">
              <h2 class="card-title text-lg line-clamp-2">{item.book.title}</h2>
              <p class="text-sm text-base-content/70 line-clamp-1">{item.book.author}</p>
              <p class="text-xs text-base-content/60">{item.book.published_year}</p>

              <div class="card-actions justify-between items-center mt-4">
                <.link
                  navigate={~p"/books/#{item.book.id}"}
                  class="btn btn-sm btn-primary"
                >
                  View Details
                </.link>

                <button
                  phx-click="toggle_favorite"
                  phx-value-id={item.book.id}
                  class={[
                    "btn btn-sm btn-circle",
                    if(item.is_favorited, do: "btn-error", else: "btn-ghost")
                  ]}
                  title={if item.is_favorited, do: "Remove from favorites", else: "Add to favorites"}
                >
                  <.icon
                    name={if item.is_favorited, do: "hero-heart-solid", else: "hero-heart"}
                    class="w-5 h-5"
                  />
                </button>
              </div>
            </div>
          </div>
        </div>

        <%= if @books == [] do %>
          <div class="text-center py-12">
            <p class="text-xl text-base-content/70">No books found.</p>
          </div>
        <% end %>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_scope.user.id
    books = Library.list_books_with_favorites(user_id)

    {:ok, assign(socket, books: books)}
  end

  @impl true
  def handle_event("toggle_favorite", %{"id" => book_id}, socket) do
    user_id = socket.assigns.current_scope.user.id
    Library.toggle_favorite(user_id, String.to_integer(book_id))

    # Reload books with updated favorite status
    books = Library.list_books_with_favorites(user_id)

    {:noreply, assign(socket, books: books)}
  end
end
