defmodule Day5.Part2 do
  alias Day5.Logic

  def main() do
    data = File.read!("input.txt")
    cnt = data
      |> String.split("\n", trim: true)
      |> Enum.count(fn str -> Logic.is_nice_part_2?(str) end)

    IO.puts "Result = #{cnt}\n"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
