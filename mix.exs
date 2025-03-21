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
      {:plug_cowboy, "~> 2.5"}, # HTTP server for Plug
      {:ueberauth, "~> 0.10"}, # Authentication framework
      {:ueberauth_google, "~> 0.10"}, # Google OAuth provider
      {:jason, "~> 1.4"}, # JSON parsing
    ]
  end
end

