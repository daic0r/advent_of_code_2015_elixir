defmodule Day4.Part2 do
  
  def wait(server) do
    case Day4.Part2.GenServer.done?(server) do
      false ->
        Process.sleep(1000)
        wait(server)
      true ->
        results = Day4.Part2.GenServer.get_result(server)
        IO.puts "Done\n"
        result = Enum.min(results)
        IO.puts "Result: #{result}\n"
    end
  end
  def main() do
    input = "iwrupvqb" 
    
    {:ok, server} = GenServer.start_link(Day4.Part2.GenServer, input)
    wait(server)
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
