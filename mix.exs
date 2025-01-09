defmodule ElixirRenovateDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_renovate_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: dialyzer()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ElixirRenovateDemo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp dialyzer() do
    [
      plt_local_path: "priv/plts/project.plt",
      plt_core_path: "priv/plts/core.plt"
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "== 1.7.14"},
      {:phoenix_ecto, "== 4.6.3"},
      {:ecto_sql, "== 3.11.3"},
      {:postgrex, "== 0.18.0"},
      {:phoenix_html, "== 4.1.1"},
      {:phoenix_live_reload, "== 1.5.3", only: :dev},
      {:phoenix_live_view, "== 0.20.17"},
      {:floki, "== 0.36.2", only: :test},
      {:phoenix_live_dashboard, "== 0.8.6"},
      {:esbuild, "== 0.8.1", runtime: Mix.env() == :dev},
      {:tailwind, "== 0.2.3", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.2.0",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "== 1.16.9"},
      {:finch, "== 0.18.0"},
      {:telemetry_metrics, "== 1.0.0"},
      {:telemetry_poller, "== 1.1.0"},
      {:gettext, "== 0.24.0"},
      {:jason, "== 1.4.1"},
      {:dns_cluster, "== 0.1.3"},
      {:bandit, "== 1.5.4"},
      {:dialyxir, "== 1.4.3", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind elixir_renovate_demo", "esbuild elixir_renovate_demo"],
      "assets.deploy": [
        "tailwind elixir_renovate_demo --minify",
        "esbuild elixir_renovate_demo --minify",
        "phx.digest"
      ]
    ]
  end
end
