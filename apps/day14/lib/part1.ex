defmodule Day14.Part1 do
  def process(input, limit) do
   # Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds. 
   result = input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> IO.inspect
     [name, speed, travel_dur, pause_dur] = Regex.run(~r/(.+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./, line, capture: :all_but_first)
      %{ name: name, speed: elem(Integer.parse(speed), 0), travel_dur: elem(Integer.parse(travel_dur), 0), pause_dur: elem(Integer.parse(pause_dur), 0) }
    end)
    |> IO.inspect
    |> Enum.map(fn data ->
      num_intervals = div(limit, data.travel_dur + data.pause_dur)
      remain = rem(limit, data.travel_dur + data.pause_dur)
      {data.name, (num_intervals * data.travel_dur * data.speed) + (min(remain, data.travel_dur) * data.speed)}
    end)
    |> IO.inspect
    |> Enum.max_by(fn {_name, distance} ->
      distance 
    end)
      
    elem(result, 1)
  end
  def main() do
    input = File.read!("input.txt")
    # input = """
    # Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
    # Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
    # """
    result = process(input, 2503)

    IO.puts "Result = #{result}"
  end
  def start_link do
    main()
    {:ok, self()}
  end
end
