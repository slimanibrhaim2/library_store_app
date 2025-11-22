defmodule LibraryStoreApp.Repo do
  use Ecto.Repo,
    otp_app: :library_store_app,
    adapter: Ecto.Adapters.Postgres
end
