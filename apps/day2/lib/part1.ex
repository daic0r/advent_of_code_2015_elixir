defmodule Day2.Part1 do
  def process() do
    File.read!("input.txt")    
    |> String.split("\n")
    |> Enum.filter(& String.length(&1) > 0)
    |> Enum.map(fn line ->
      IO.puts line
      [l, w, h] = Regex.run(~r/(\d+)x(\d+)x(\d+)/, line, capture: :all_but_first) |> IO.inspect
      %{ l: elem(Integer.parse(l), 0), w: elem(Integer.parse(w), 0), h: elem(Integer.parse(h), 0) }
    end)
    |> Enum.map(fn %{ l: l, w: w, h: h } ->
      [2*l*w, 2*w*h, 2*h*l]
    end)
    |> Enum.map(fn [a, b, c] = sides -> 
      a + b + c + div(Enum.min(sides), 2)
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
