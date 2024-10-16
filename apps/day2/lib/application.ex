defmodule Day2.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{id: Day2.Part2, start: {Day2.Part2, :start_link, []} },
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Day2.Supervisor)
  end
end
