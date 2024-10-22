defmodule Day3.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{id: Day3.Part2, start: {Day3.Part2, :start_link, []} },
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Day3.Supervisor)
  end
end
