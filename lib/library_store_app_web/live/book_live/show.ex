defmodule LibraryStoreAppWeb.BookLive.Show do
  use LibraryStoreAppWeb, :live_view

  alias LibraryStoreApp.Library

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-base-100 via-base-200 to-base-300">
        <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <%!-- Navigation --%>
          <div class="flex justify-between items-center mb-8">
            <.link navigate={~p"/books"} class="btn btn-ghost gap-2">
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
                  d="M10 19l-7-7m0 0l7-7m-7 7h18"
                />
              </svg>
              Back to Books
            </.link>

            <div class="flex gap-2">
              <.link navigate={~p"/users/settings"} class="btn btn-ghost btn-sm gap-2">
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
            </div>
          </div>

          <%!-- Book Details Card --%>
          <div class="card lg:card-side bg-base-100 shadow-2xl overflow-hidden">
            <%!-- Book Cover Section --%>
            <figure class="lg:w-2/5 bg-gradient-to-br from-purple-50 to-pink-50 p-8 flex items-center justify-center">
              <div class="relative">
                <%= if @is_favorited do %>
                  <div class="absolute -top-4 -right-4 z-10">
                    <div class="badge badge-error badge-lg gap-2 shadow-xl">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-4 w-4"
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
                  src={@book.cover_url}
                  alt={@book.title}
                  class="rounded-2xl max-h-[500px] object-contain bg-white p-6 shadow-2xl"
                  onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 400 600%22%3E%3Crect fill=%22%23f3f4f6%22 width=%22400%22 height=%22600%22/%3E%3Cpath d=%22M200 150 L200 350 M200 150 C180 160 160 170 140 185 C120 200 100 220 100 250 L100 450 M200 150 C220 160 240 170 260 185 C280 200 300 220 300 250 L300 450 M100 450 L300 450%22 stroke=%22%239ca3af%22 stroke-width=%224%22 fill=%22none%22 stroke-linecap=%22round%22/%3E%3Ctext x=%22200%22 y=%22520%22 text-anchor=%22middle%22 fill=%22%236b7280%22 font-family=%22Arial%22 font-size=%2220%22 font-weight=%22bold%22%3ENo Image%3C/text%3E%3C/svg%3E';"
                />
              </div>
            </figure>

            <%!-- Book Information Section --%>
            <div class="card-body lg:w-3/5">
              <div class="flex justify-between items-start mb-6">
                <div class="flex-1">
                  <h1 class="text-4xl font-bold mb-4 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                    {@book.title}
                  </h1>
                  <div class="flex items-center gap-2 text-xl text-base-content/80 mb-4">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-6 w-6 text-primary"
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
                    <span class="font-semibold">by {@book.author}</span>
                  </div>
                </div>

                <button
                  phx-click="toggle_favorite"
                  class={[
                    "btn btn-lg btn-circle",
                    if(@is_favorited, do: "btn-error hover:btn-ghost", else: "btn-ghost hover:btn-error")
                  ]}
                  title={if @is_favorited, do: "Remove from favorites", else: "Add to favorites"}
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-8 w-8"
                    fill={if @is_favorited, do: "currentColor", else: "none"}
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
                </button>
              </div>

              <%!-- Book Metadata --%>
              <div class="grid grid-cols-2 gap-4 mb-6">
                <div class="stat bg-base-200 rounded-lg p-4">
                  <div class="stat-figure text-primary">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-8 w-8"
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
                  </div>
                  <div class="stat-title">Published</div>
                  <div class="stat-value text-2xl">{@book.published_year}</div>
                </div>

                <div class="stat bg-base-200 rounded-lg p-4">
                  <div class="stat-figure text-secondary">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-8 w-8"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14"
                      />
                    </svg>
                  </div>
                  <div class="stat-title">ISBN</div>
                  <div class="stat-value text-lg">{@book.isbn}</div>
                </div>
              </div>

              <div class="divider"></div>

              <%!-- Description --%>
              <div>
                <div class="flex items-center gap-2 mb-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-6 w-6 text-primary"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                    />
                  </svg>
                  <h2 class="text-2xl font-semibold">About This Book</h2>
                </div>
                <p class="text-base-content/80 leading-relaxed text-lg">{@book.description}</p>
              </div>
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
