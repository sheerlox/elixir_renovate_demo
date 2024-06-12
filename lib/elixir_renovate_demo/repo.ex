defmodule ElixirRenovateDemo.Repo do
  use Ecto.Repo,
    otp_app: :elixir_renovate_demo,
    adapter: Ecto.Adapters.Postgres
end
