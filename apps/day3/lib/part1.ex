defmodule Day3.Part1 do
  def process(<<>>, {x,y}, map) do
    prev_count = Map.get(map, {x, y})
    case prev_count do
      nil ->
        Map.put(map, {x,y}, 1) 
      _ ->
        Map.put(map, {x,y}, prev_count + 1)
    end
  end
  def process(<<step, rest::binary>>, {x,y}, map) do
    prev_count = Map.get(map, {x, y})
    map = case prev_count do
      nil ->
        Map.put(map, {x,y}, 1) 
      _ ->
        Map.put(map, {x,y}, prev_count + 1)
    end

    case step do
      ?> ->
        process(rest, {x + 1, y}, map)
      ?< ->
        process(rest, {x - 1, y}, map)
      ?^ ->
        process(rest, {x, y + 1}, map)
      ?v ->
        process(rest, {x, y - 1}, map)
      ch ->
        raise "Can't process #{to_string(ch)}"
    end
  end

  def main() do
    data = 
      File.read!("input.txt")
      |> String.trim()
    result = process(data, {0,0}, %{})
    IO.puts "Result = #{map_size(result)}\n"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
