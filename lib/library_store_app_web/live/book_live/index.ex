defmodule LibraryStoreAppWeb.BookLive.Index do
  use LibraryStoreAppWeb, :live_view

  alias LibraryStoreApp.Library

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-base-100 via-base-200 to-base-300">
        <%!-- Hero Header --%>
        <div class="bg-gradient-to-r from-purple-600 to-pink-600 text-white">
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="flex flex-col md:flex-row justify-between items-center gap-6">
              <div class="text-center md:text-left">
                <div class="flex items-center justify-center md:justify-start gap-3 mb-4">
                  <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-10 w-10"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                      />
                    </svg>
                  </div>
                  <div>
                    <h1 class="text-4xl md:text-5xl font-bold">Library Store</h1>
                    <p class="text-white/90 text-lg mt-1">
                      Discover Your Next Programming Adventure
                    </p>
                  </div>
                </div>
                <div class="flex gap-4 justify-center md:justify-start items-center">
                  <div class="badge badge-lg bg-white/20 border-white/30 text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-4 w-4 mr-2"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                      />
                    </svg>
                    {length(@books)} Books Available
                  </div>
                  <div class="badge badge-lg bg-white/20 border-white/30 text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-4 w-4 mr-2"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                      />
                    </svg>
                    {Enum.count(@books, fn item -> item.is_favorited end)} Favorites
                  </div>
                </div>
              </div>

              <div class="flex flex-col sm:flex-row gap-3">
                <.link navigate={~p"/users/settings"} class="btn btn-ghost bg-white/10 border-white/20 hover:bg-white/20 text-white gap-2">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
                    />
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                    />
                  </svg>
                  Settings
                </.link>
                <.link
                  href={~p"/users/log-out"}
                  method="delete"
                  class="btn btn-ghost bg-white/10 border-white/20 hover:bg-white/20 text-white gap-2"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                    />
                  </svg>
                  Log Out
                </.link>
              </div>
            </div>
          </div>
        </div>

        <%!-- Books Grid --%>
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <%= if @books == [] do %>
            <div class="text-center py-20">
              <div class="inline-flex items-center justify-center w-24 h-24 rounded-full bg-base-300 mb-6">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-12 w-12 text-base-content/40"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                  />
                </svg>
              </div>
              <h3 class="text-2xl font-bold mb-2">No Books Found</h3>
              <p class="text-base-content/70">Check back soon for new additions to our library!</p>
            </div>
          <% else %>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
              <div
                :for={item <- @books}
                class="group card bg-base-100 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2"
              >
                <%!-- Book Cover --%>
                <figure class="px-6 pt-6 relative overflow-hidden">
                  <%= if item.is_favorited do %>
                    <div class="absolute top-8 right-8 z-10">
                      <div class="badge badge-error gap-1 shadow-lg">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          class="h-3 w-3"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                        >
                          <path
                            fill-rule="evenodd"
                            d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z"
                            clip-rule="evenodd"
                          />
                        </svg>
                        Favorite
                      </div>
                    </div>
                  <% end %>
                  <img
                    src={item.book.cover_url}
                    alt={item.book.title}
                    class="rounded-xl h-72 w-full object-contain bg-white p-4 group-hover:scale-105 transition-transform duration-300"
                    onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 400 600%22%3E%3Crect fill=%22%23f3f4f6%22 width=%22400%22 height=%22600%22/%3E%3Cpath d=%22M200 150 L200 350 M200 150 C180 160 160 170 140 185 C120 200 100 220 100 250 L100 450 M200 150 C220 160 240 170 260 185 C280 200 300 220 300 250 L300 450 M100 450 L300 450%22 stroke=%22%239ca3af%22 stroke-width=%224%22 fill=%22none%22 stroke-linecap=%22round%22/%3E%3Ctext x=%22200%22 y=%22520%22 text-anchor=%22middle%22 fill=%22%236b7280%22 font-family=%22Arial%22 font-size=%2220%22 font-weight=%22bold%22%3ENo Image%3C/text%3E%3C/svg%3E';"
                  />
                </figure>

                <%!-- Book Info --%>
                <div class="card-body">
                  <div class="mb-3">
                    <h2 class="card-title text-lg line-clamp-2 group-hover:text-primary transition-colors">
                      {item.book.title}
                    </h2>
                    <p class="text-sm text-base-content/70 line-clamp-1 flex items-center gap-2 mt-2">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-4 w-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                        />
                      </svg>
                      {item.book.author}
                    </p>
                    <p class="text-xs text-base-content/60 flex items-center gap-2 mt-1">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-4 w-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                        />
                      </svg>
                      Published {item.book.published_year}
                    </p>
                  </div>

                  <%!-- Actions --%>
                  <div class="card-actions justify-between items-center mt-4 pt-4 border-t border-base-300">
                    <.link
                      navigate={~p"/books/#{item.book.id}"}
                      class="btn btn-sm btn-primary gap-2 flex-1"
                    >
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-4 w-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                        />
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                        />
                      </svg>
                      View Details
                    </.link>

                    <button
                      phx-click="toggle_favorite"
                      phx-value-id={item.book.id}
                      class={[
                        "btn btn-sm btn-circle",
                        if(item.is_favorited,
                          do: "btn-error hover:btn-ghost",
                          else: "btn-ghost hover:btn-error"
                        )
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
          <% end %>
        </div>
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
