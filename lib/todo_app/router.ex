defmodule TodoApp.Router do
  use Plug.Router
  use Plug.Session,
    store: :cookie,
    key: "_todo_app_session",
    signing_salt: "random_salt"

  plug Plug.Logger
  plug Ueberauth  # Ensure Ueberauth is properly plugged

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Welcome to the To-Do App!")
  end

  get "/auth/google" do
    Ueberauth.Strategy.Google.handle_request!(conn)
  end

  get "/auth/google/callback" do
    conn = Ueberauth.Strategy.Google.handle_callback!(conn)
    send_resp(conn, 200, "Google OAuth successful!")
  end

  match _ do
    send_resp(conn, 404, "Oops! Page not found.")
  end
end

