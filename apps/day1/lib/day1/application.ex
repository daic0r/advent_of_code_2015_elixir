defmodule Day1.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{id: Day1.Part2, start: {Day1.Part2, :start_link, []}},
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Day1.Supervisor)
  end
end
