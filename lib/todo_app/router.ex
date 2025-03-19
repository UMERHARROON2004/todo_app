defmodule TodoApp.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Welcome to Umer's TODO App!")
  end

  get "/todos" do
    send_resp(conn, 200, Jason.encode!(%{todos: ["Buy milk", "Read Elixir book"]}))
  end

  match _ do
    send_resp(conn, 404, "Oops! Not found")
  end
end
