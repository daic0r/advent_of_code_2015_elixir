defmodule Day1.Part1 do
  def process(<<>>, level) do
    level
  end

  def process(<<")", rest::binary>>, level) do
    process(rest, level - 1) 
  end

  def process(<<"(", rest::binary>>, level) do
    process(rest, level + 1) 
  end

  def main() do
    data = File.read!("input.txt") |> String.trim_trailing()

    result = process(data, 0)
    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
