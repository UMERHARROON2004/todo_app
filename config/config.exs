import Config

config :todo_app, TodoApp.Repo,
  database: "todo_app_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

# Ueberauth main config with Google strategy
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

# Google OAuth credentials (pulled from environment variables)
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Optional: Argon2 password hashing config (safe defaults)
config :argon2_elixir,
  t_cost: 2,
  m_cost: 16
