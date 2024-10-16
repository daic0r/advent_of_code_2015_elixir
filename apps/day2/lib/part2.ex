defmodule Day2.Part2 do
  def process() do
    File.read!("input.txt")    
    |> String.split("\n")
    |> Enum.filter(& String.length(&1) > 0)
    |> Enum.map(fn line ->
      IO.puts line
      [l, w, h] = Regex.run(~r/(\d+)x(\d+)x(\d+)/, line, capture: :all_but_first) |> IO.inspect
      %{ l: elem(Integer.parse(l), 0), w: elem(Integer.parse(w), 0), h: elem(Integer.parse(h), 0) }
    end)
    |> Enum.map(fn %{ l: l, w: w, h: h } = box ->
      l = [l, w, h]
      idx_max = l |> Enum.find_index(fn e -> e == Enum.max(l) end)
      {first, second} = Enum.split(l, idx_max)
      { first ++ tl(second), box }
    end)
    |> Enum.map(fn { [s1, s2], %{ l: l, w: w, h: h } } -> 
      s1 + s1 + s2 + s2 + (l * w * h)
    end)
    |> Enum.sum
  end

  def main() do
    result = process()
    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
