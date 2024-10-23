defmodule Day5.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Day5.Worker.start_link(arg)
      # {Day5.Worker, arg}
      %{id: Day5.Part2, start: {Day5.Part2, :start_link, []}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day5.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
