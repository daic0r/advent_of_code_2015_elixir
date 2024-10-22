defmodule Day3.Part2 do
  def process([], {x,y}, map) do
    prev_count = Map.get(map, {x, y})
    case prev_count do
      nil ->
        Map.put(map, {x,y}, 1) 
      _ ->
        Map.put(map, {x,y}, prev_count + 1)
    end
  end
  def process([ step | rest ], {x,y}, map) do
    prev_count = Map.get(map, {x, y})
    map = case prev_count do
      nil ->
        Map.put(map, {x,y}, 1) 
      _ ->
        Map.put(map, {x,y}, prev_count + 1)
    end

    case step do
      ">" ->
        process(rest, {x + 1, y}, map)
      "<" ->
        process(rest, {x - 1, y}, map)
      "^" ->
        process(rest, {x, y + 1}, map)
      "v" ->
        process(rest, {x, y - 1}, map)
      ch ->
        raise "Can't process #{to_string(ch)}"
    end
  end

  def main() do
    data = 
      File.read!("input.txt")
      |> String.trim()
    data1 = data |> String.graphemes |> Enum.take_every(2)
    data2 = data |> String.graphemes |> Enum.drop(1) |> Enum.take_every(2)
    result1 = process(data1, {0,0}, %{})
    result2 = process(data2, {0,0}, %{})
    result = Map.merge(result1, result2)
    IO.puts "Result = #{map_size(result)}\n"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
