defmodule Day14.Part2 do

  def get_distance_after(%{ speed: speed, travel_dur: travel_dur, pause_dur: pause_dur }, time) do
    num_intervals = div(time, travel_dur + pause_dur)
    remain = rem(time, travel_dur + pause_dur)
    (num_intervals * travel_dur * speed) + (min(remain, travel_dur) * speed) 
  end

  def process(input, limit) do
   # Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds. 
   result = input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> IO.inspect
     [name, speed, travel_dur, pause_dur] = Regex.run(~r/(.+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./, line, capture: :all_but_first)
      %{ name: name, speed: elem(Integer.parse(speed), 0), travel_dur: elem(Integer.parse(travel_dur), 0), pause_dur: elem(Integer.parse(pause_dur), 0) }
    end)

    winners_by_round = for t <- 1..limit do
      groups = Enum.group_by(result, fn data ->
        dist = get_distance_after(data, t)
        dist
      end)
      winners = 
        groups 
        |> Enum.max_by(fn {dist, _data} -> 
          dist
        end)
        |> elem(1)
      winners
    end

    winner_points = winners_by_round
      |> List.flatten
      |> Enum.group_by(& &1)
      |> Enum.max_by(fn {_name, rounds_won} -> length(rounds_won) end)
      |> elem(1)
      |> length
      
    winner_points
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
