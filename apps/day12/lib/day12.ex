defmodule Day12 do
  @part 2

  def process(input, acc) when is_number(input) do
    input + acc
  end
  def process(input, acc) when is_binary(input) do
    acc
  end
  def process(input, acc) when is_list(input) do
    acc + Enum.reduce(input, 0, fn x, acc ->
      IO.inspect(x)
      acc + process(x, 0)
    end)
  end
  def process(input, acc) when is_map(input) and @part == 1 do
    acc + Enum.reduce(input, 0, fn {_key,val}, acc -> acc + process(val, 0) end)
  end
  def process(input, acc) when is_map(input) and @part == 2 do
    if Enum.any?(input, fn {key, val} -> key == "red" or val == "red" end) do
      acc
    else
      acc + Enum.reduce(input, 0, fn {_key,val}, acc -> acc + process(val, 0) end)
    end
  end
      
  def main() do
    input = File.read!("input.txt")
    input_json = Jason.decode!(input) |> IO.inspect
    result = process(input_json, 0)

    IO.puts "Part #{@part} Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
