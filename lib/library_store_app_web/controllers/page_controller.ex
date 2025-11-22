defmodule LibraryStoreAppWeb.PageController do
  use LibraryStoreAppWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
