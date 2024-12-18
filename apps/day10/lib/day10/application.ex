defmodule Day10.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Day10.Worker.start_link(arg)
      # {Day10.Worker, arg}
      %{id: Day10.Part1, start: {Day10.Part1, :start_link, []}},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day10.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
