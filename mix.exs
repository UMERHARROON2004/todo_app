defmodule TodoApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo_app,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {TodoApp, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:plug, "~> 1.13"},
      {:ueberauth, "~> 0.10"},
      {:ueberauth_google, "~> 0.12"},
      {:jason, "~> 1.4"},
      {:ecto_sql, "~> 3.12"},   # Add this
      {:myxql, "~> 0.7"},
      {:argon2_elixir, "~> 3.0"}, # Password hashing
    ]
  end
end