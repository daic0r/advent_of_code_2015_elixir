defmodule Day13.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Day13.Worker.start_link(arg)
      # {Day13.Worker, arg}
      %{ id: Day13, start: {Day13, :start_link, []} }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day13.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
