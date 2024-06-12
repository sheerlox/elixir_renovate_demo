defmodule ElixirRenovateDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirRenovateDemoWeb.Telemetry,
      ElixirRenovateDemo.Repo,
      {DNSCluster,
       query: Application.get_env(:elixir_renovate_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirRenovateDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirRenovateDemo.Finch},
      # Start a worker by calling: ElixirRenovateDemo.Worker.start_link(arg)
      # {ElixirRenovateDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirRenovateDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirRenovateDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirRenovateDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
