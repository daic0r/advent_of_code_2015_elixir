defmodule Day4.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Day4.Worker.start_link(arg)
      # {Day4.Worker, arg}
      %{id: Day4.Part1, start: {Day4.Part1, :start_link, []}},
      %{id: Day4.Part2, start: {Day4.Part2, :start_link, []}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day4.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
