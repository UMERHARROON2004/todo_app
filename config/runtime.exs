import Config

# Ensure correct database settings
config :todo_app, TodoApp.Repo,
  username: "root",
  password: "umer1234",
  database: "todo_app_db",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
