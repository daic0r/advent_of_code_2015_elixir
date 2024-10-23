defmodule Day4.Part2.GenServer do
  use GenServer

  @step_size 1_000_000

  def start_link(input, _opts) do
    GenServer.start_link(__MODULE__, input, [])
  end

  def done?(server) do
    GenServer.call(server, :query_done)
  end

  def get_result(server) do
    GenServer.call(server, :get_result)
  end

  @impl true
  def init(input) do
    IO.puts "Spawning tasks...\n"
    tasks = spawn_tasks(input, 0, MapSet.new())
    ret = %{ tasks: tasks, results: [] }
    {:ok, ret}
  end

  @impl true
  def handle_call(:query_done, _from, state) do
    {:reply, Map.get(state, :result) != nil || MapSet.size(Map.get(state, :tasks)) == 0, state}
  end

  @impl true
  def handle_call(:get_result, _from, state) do
    {:reply, Map.get(state, :results), state}
  end

  @impl true
  def handle_info({_ref, :not_found}, state) do
    IO.puts "Task stopped with no result\n"
    {:noreply, state}
  end

  @impl true
  def handle_info({_ref, {:found, num}}, state) do
    IO.puts "Found number! Result = #{num}\n"
    {:noreply, %{ state | results: [ num | state.results ] }}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, :normal}, state) when is_map(state) do
    IO.puts "Process down, removing\n"
    {_, state} = Map.get_and_update(state, :tasks, fn tasks ->
      {tasks, MapSet.filter(tasks, fn task -> task.pid != pid end)}
    end)
    {:noreply, state}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message: #{inspect(msg)}, state: #{is_map(state)}")
    {:noreply, state}
  end

  defp step_size do
    @step_size
  end

  defp process(_input, num, limit) when num == limit+1 do
    :not_found
  end
  defp process(input, num, limit) do
    hash = :crypto.hash(:md5, input <> Integer.to_string(num)) |> Base.encode16
    case String.slice(hash, 0..5) do
      "000000" -> {:found, num}
      _ -> process(input, num + 1, limit)
    end
  end

  defp spawn_tasks(_input, start_idx, tasks) when start_idx >= 100*@step_size do
    tasks
  end
  defp spawn_tasks(input, start_idx, tasks) do
    task = Task.async(fn -> process(input, start_idx, start_idx + step_size() - 1) end)
    tasks = MapSet.put(tasks, task)
    spawn_tasks(input, start_idx + step_size(), tasks)
  end

end
