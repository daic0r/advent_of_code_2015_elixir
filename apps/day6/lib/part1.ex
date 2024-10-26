defmodule Day6.Part1 do
  alias Day6.Lightsfield

  @spec parse_line(String.t(), pid()) :: any
  def parse_line(str, server) do
    parse_result = Regex.run(~r/(.+) (\d+),(\d+) through (\d+),(\d+)/, str, capture: :all_but_first)
    [command | coords] = parse_result
    [from_x | coords] = coords
    from_x = String.to_integer(from_x)
    [from_y | coords] = coords
    from_y = String.to_integer(from_y)
    [to_x | coords] = coords
    to_x = String.to_integer(to_x)
    [to_y | _] = coords
    to_y = String.to_integer(to_y)

    case command do
      "turn on" -> 
        IO.puts "Turning on lights from {#{from_x}, #{from_y}} to {#{to_x}, #{to_y}}"
        Lightsfield.switch_on(server, {from_x, from_y}, {to_x, to_y})
      "turn off" -> 
        IO.puts "Turning off lights from {#{from_x}, #{from_y}} to {#{to_x}, #{to_y}}"
        Lightsfield.switch_off(server, {from_x, from_y}, {to_x, to_y})
      "toggle" -> 
        IO.puts "Toggling lights from {#{from_x}, #{from_y}} to {#{to_x}, #{to_y}}"
        Lightsfield.toggle(server, {from_x, from_y}, {to_x, to_y})
      _ -> 
        IO.puts "Unknown command: #{command}\n"
    end
  end


  def process(server) do
    lines = File.read!("input.txt")

    lines
      |> String.split("\n", trim: true)
      |> Enum.each(fn line ->
        parse_line(line, server)
      end)


    Lightsfield.get_field(server)
      |> :array.to_list()
      |> Enum.count(& &1 == true)
  end

  def main(server) do
    result = process(server)
    IO.puts "Result = #{result}"
  end
 
  def start_link do
    {:ok, server} = GenServer.start_link(Day6.Lightsfield, [])
    main(server)
    {:ok, self()}
  end
end
