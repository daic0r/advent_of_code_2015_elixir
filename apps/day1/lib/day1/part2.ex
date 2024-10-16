defmodule Day1.Part2 do
  def process(<<>>, level, idx) do
    idx - 1
  end

  def process(<<")", _rest::binary>>, -1, idx) do
    idx - 1
  end

  def process(<<")", rest::binary>>, level, idx) do
    process(rest, level - 1, idx + 1) 
  end

  def process(<<"(", rest::binary>>, level, idx) do
    process(rest, level + 1, idx + 1) 
  end

  def main() do
    data = File.read!("input.txt") |> String.trim_trailing()

    result = process(data, 0, 1)
    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
