defmodule LibraryStoreAppWeb.UserLive.Settings do
  use LibraryStoreAppWeb, :live_view

  on_mount {LibraryStoreAppWeb.UserAuth, :require_sudo_mode}

  alias LibraryStoreApp.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-base-100 to-base-200">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <%!-- Header Section --%>
          <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-purple-500 to-pink-500 mb-4 shadow-lg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-10 w-10 text-white"
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
            </div>
            <h1 class="text-4xl font-bold mb-2 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
              Account Settings
            </h1>
            <p class="text-base-content/70 text-lg">
              Manage your account email address and password settings
            </p>
            <p class="text-sm text-base-content/60 mt-2">
              Currently signed in as: <span class="font-semibold">{@current_email}</span>
            </p>

            <div class="flex gap-3 justify-center mt-6">
              <.link navigate={~p"/books"} class="btn btn-primary gap-2">
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
                    d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                  />
                </svg>
                Browse Books
              </.link>

              <.link href={~p"/users/log-out"} method="delete" class="btn btn-ghost gap-2">
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

          <%!-- Settings Cards --%>
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <%!-- Email Card --%>
            <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-all">
              <div class="card-body">
                <div class="flex items-center gap-3 mb-4">
                  <div class="w-12 h-12 rounded-lg bg-blue-500/10 flex items-center justify-center">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-6 w-6 text-blue-500"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
                      />
                    </svg>
                  </div>
                  <div>
                    <h2 class="card-title text-xl">Email Address</h2>
                    <p class="text-sm text-base-content/60">Update your email for account access</p>
                  </div>
                </div>

                <.form
                  for={@email_form}
                  id="email_form"
                  phx-submit="update_email"
                  phx-change="validate_email"
                >
                  <.input
                    field={@email_form[:email]}
                    type="email"
                    label="New Email Address"
                    autocomplete="username"
                    required
                  />
                  <.button variant="primary" class="w-full" phx-disable-with="Changing...">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-5 w-5 mr-2"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M5 13l4 4L19 7"
                      />
                    </svg>
                    Change Email
                  </.button>
                </.form>

                <div class="alert alert-info mt-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    class="stroke-current shrink-0 w-6 h-6"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  <span class="text-sm">
                    A confirmation link will be sent to your new email address
                  </span>
                </div>
              </div>
            </div>

            <%!-- Password Card --%>
            <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-all">
              <div class="card-body">
                <div class="flex items-center gap-3 mb-4">
                  <div class="w-12 h-12 rounded-lg bg-green-500/10 flex items-center justify-center">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-6 w-6 text-green-500"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
                      />
                    </svg>
                  </div>
                  <div>
                    <h2 class="card-title text-xl">Password</h2>
                    <p class="text-sm text-base-content/60">Keep your account secure</p>
                  </div>
                </div>

                <.form
                  for={@password_form}
                  id="password_form"
                  action={~p"/users/update-password"}
                  method="post"
                  phx-change="validate_password"
                  phx-submit="update_password"
                  phx-trigger-action={@trigger_submit}
                >
                  <input
                    name={@password_form[:email].name}
                    type="hidden"
                    id="hidden_user_email"
                    autocomplete="username"
                    value={@current_email}
                  />
                  <.input
                    field={@password_form[:password]}
                    type="password"
                    label="New Password"
                    autocomplete="new-password"
                    required
                  />
                  <.input
                    field={@password_form[:password_confirmation]}
                    type="password"
                    label="Confirm New Password"
                    autocomplete="new-password"
                  />
                  <.button variant="primary" class="w-full" phx-disable-with="Saving...">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-5 w-5 mr-2"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M5 13l4 4L19 7"
                      />
                    </svg>
                    Update Password
                  </.button>
                </.form>

                <div class="alert alert-warning mt-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="stroke-current shrink-0 h-6 w-6"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
                    />
                  </svg>
                  <span class="text-sm">Password must be at least 12 characters long</span>
                </div>
              </div>
            </div>
          </div>

          <%!-- Account Info Section --%>
          <div class="mt-8 card bg-base-100 shadow-xl">
            <div class="card-body">
              <h3 class="card-title text-lg">Account Information</h3>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                <div class="stat bg-base-200 rounded-lg">
                  <div class="stat-title">Account Status</div>
                  <div class="stat-value text-2xl text-success">Active</div>
                  <div class="stat-desc">Your account is in good standing</div>
                </div>
                <div class="stat bg-base-200 rounded-lg">
                  <div class="stat-title">Email Status</div>
                  <div class="stat-value text-2xl text-success">Verified</div>
                  <div class="stat-desc">Your email is confirmed</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"token" => token}, _session, socket) do
    socket =
      case Accounts.update_user_email(socket.assigns.current_scope.user, token) do
        {:ok, _user} ->
          put_flash(socket, :info, "Email changed successfully.")

        {:error, _} ->
          put_flash(socket, :error, "Email change link is invalid or it has expired.")
      end

    {:ok, push_navigate(socket, to: ~p"/users/settings")}
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    email_changeset = Accounts.change_user_email(user, %{}, validate_unique: false)
    password_changeset = Accounts.change_user_password(user, %{}, hash_password: false)

    socket =
      socket
      |> assign(:current_email, user.email)
      |> assign(:email_form, to_form(email_changeset))
      |> assign(:password_form, to_form(password_changeset))
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate_email", params, socket) do
    %{"user" => user_params} = params

    email_form =
      socket.assigns.current_scope.user
      |> Accounts.change_user_email(user_params, validate_unique: false)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form)}
  end

  def handle_event("update_email", params, socket) do
    %{"user" => user_params} = params
    user = socket.assigns.current_scope.user
    true = Accounts.sudo_mode?(user)

    case Accounts.change_user_email(user, user_params) do
      %{valid?: true} = changeset ->
        Accounts.deliver_user_update_email_instructions(
          Ecto.Changeset.apply_action!(changeset, :insert),
          user.email,
          &url(~p"/users/settings/confirm-email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info)}

      changeset ->
        {:noreply, assign(socket, :email_form, to_form(changeset, action: :insert))}
    end
  end

  def handle_event("validate_password", params, socket) do
    %{"user" => user_params} = params

    password_form =
      socket.assigns.current_scope.user
      |> Accounts.change_user_password(user_params, hash_password: false)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: password_form)}
  end

  def handle_event("update_password", params, socket) do
    %{"user" => user_params} = params
    user = socket.assigns.current_scope.user
    true = Accounts.sudo_mode?(user)

    case Accounts.change_user_password(user, user_params) do
      %{valid?: true} = changeset ->
        {:noreply, assign(socket, trigger_submit: true, password_form: to_form(changeset))}

      changeset ->
        {:noreply, assign(socket, password_form: to_form(changeset, action: :insert))}
    end
  end
end
