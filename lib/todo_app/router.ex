defmodule TodoApp.Router do
  use Plug.Router

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.Session,
    store: :cookie,
    key: "_todo_app_session",
    signing_salt: "random_salt"

  plug Ueberauth

  plug :fetch_session
  plug :match
  plug :dispatch

  get "/" do
    conn = fetch_session(conn)
    conn_name = get_session(conn, :name)
    html = """
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>To-Do App</title>
        <style>
          body { 
            font-family: Arial, sans-serif; 
            background: linear-gradient(135deg, #ece9e6, #ffffff); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0;
          }
          .card { 
            background: #fff; 
            padding: 30px; 
            border-radius: 12px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.15); 
            text-align: center; 
            width: 300px;
          }
          h1 { color: #222; margin-bottom: 20px; }
          .btn, input[type="submit"] { 
            display: block; 
            width: 100%; 
            margin-top: 10px; 
            padding: 12px; 
            background: #4CAF50; 
            color: white; 
            text-decoration: none; 
            border: none; 
            border-radius: 5px; 
            transition: background 0.3s;
          }
          .btn:hover, input[type="submit"]:hover { background: #43a047; cursor: pointer; }
          input[type="text"] { 
            width: 100%; 
            padding: 10px; 
            margin-top: 10px; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
          }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>Welcome to the To-Do App!</h1>
          #{if conn_name do
              "<p>Hello, #{conn_name}!</p>
              <a class='btn' href='/logout'>Logout</a>"
            else
              """
              <form method='POST' action='/login'>
                <input type='text' name='name' placeholder='Enter your name' required />
                <input type='submit' value='Local Login' />
              </form>
              <a class='btn' href='/auth/google'>Sign in with Google</a>
              """
            end
          }
        </div>
      </body>
    </html>
    """
    send_resp(conn, 200, html)
  end

  post "/login" do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    params = URI.decode_query(body)
    conn = fetch_session(conn)
    conn = put_session(conn, :name, params["name"] || "Guest")
    conn
    |> put_resp_header("location", "/")
    |> send_resp(302, "")
  end

  get "/logout" do
    conn = fetch_session(conn)
    conn
    |> configure_session(drop: true)
    |> put_resp_header("location", "/")
    |> send_resp(302, "")
  end

  get "/auth/google" do
    send_resp(conn, 200, "Redirecting to Google...")
  end

  get "/auth/google/callback" do
    send_resp(conn, 200, "Google OAuth successful!")
  end

  match _ do
    send_resp(conn, 404, "Oops! Page not found.")
  end
end
