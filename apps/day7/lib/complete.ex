defmodule Day7.Part1 do
  import Bitwise

  def parse_op(a, op, b) when is_integer(a) and is_integer(b) do
    x = case op do
      "AND" ->
        a &&& b
      "OR" ->
        a ||| b
      "LSHIFT" ->
        a <<< b
      "RSHIFT" ->
        a >>> b
      _ -> raise "Invalid op"
    end
    x &&& 0xFFFF
  end
  def parse_op(a, op, b) do
    [a, op, b] 
  end

  def make_deps_map([], state) do
    state
  end
  def make_deps_map([line | rest], state) do
    import Bitwise
    IO.puts line
    [part1, dest] = String.split(line, " -> ") 
    parts = String.split(part1, " ")
    state = case length(parts) do
      1 -> 
        [right] = parts
        case Integer.parse(right) do
          {val, _} -> 
            Map.put(state, dest, val &&& 0xFFFF)
          :error -> Map.put(state, dest, right)
        end
      2 ->
        [op, right] = parts
        case Integer.parse(right) do
          {val, _} -> 
            x = case op do
              "NOT" ->
              ~~~val
              _ -> raise "Invalid op"
            end
            Map.put(state, dest, x &&& 0xFFFF)
          :error -> Map.put(state, dest, [op, right])
        end
      3 ->
        [left, op, right] = parts
        a = case Integer.parse(left) do
          {val, _} -> val
          :error -> left
        end
        b = case Integer.parse(right) do
          {val, _} -> val
          :error -> right
        end
        Map.put(state, dest, parse_op(a, op, b))
    end
    make_deps_map(rest, state) 
  end

  def trace_wire(wire, deps_map) do
    case Map.get(deps_map, wire) do
      a when is_integer(a) ->
        {deps_map, a}
      a when is_binary(a) ->
        {deps_map, val} = trace_wire(a, deps_map)
        {Map.put(deps_map, wire, val), val}
      ["NOT", b] when is_binary(b) ->
        {deps_map, val} = trace_wire(b, deps_map)
        {Map.put(deps_map, wire, ~~~val), ~~~val}
      [a, op, b] when is_integer(a) and is_binary(b) ->
        {deps_map, val} = trace_wire(b, deps_map)
        val = case op do
          "AND" ->
            a &&& val
          "OR" ->
            a ||| val
          "LSHIFT" ->
            a <<< val
          "RSHIFT" ->
            a >>> val
          _ -> raise "Invalid op"
        end
        {Map.put(deps_map, wire, val), val}
      [a, op, b] when is_binary(a) and is_integer(b) ->
        {deps_map, val} = trace_wire(a, deps_map)
        val = case op do
          "AND" ->
            val &&& b
          "OR" ->
            val ||| b
          "LSHIFT" ->
            val <<< b
          "RSHIFT" ->
            val >>> b
          _ -> raise "Invalid op"
        end
        {Map.put(deps_map, wire, val), val}
      [a, op, b] ->
        {deps_map, val_a} = trace_wire(a, deps_map)
        {deps_map, val_b} = trace_wire(b, deps_map)
        val = case op do
          "AND" ->
            val_a &&& val_b
          "OR" ->
            val_a ||| val_b
          "LSHIFT" ->
            val_a <<< val_b
          "RSHIFT" ->
            val_a >>> val_b
          _ -> raise "Invalid op"
        end
        {Map.put(deps_map, wire, val), val}
    end 
  end

  @spec process(String.t()) :: Integer
  def process(input) do
    deps_map = input
      |> String.split("\n", trim: true)
      |> make_deps_map(Map.new())

###################################
# Part 2
    deps_map = Map.put(deps_map, "b", 16076)
###################################
    IO.inspect deps_map
    {_, val} = trace_wire("a", deps_map)
    val
  end

  def main do
    input = File.read!("input.txt")

    result = process(input)
    IO.puts "Result = \"#{result}\"\n"
  end

  def start_link do 
    main()
    {:ok, self()}
  end
end
