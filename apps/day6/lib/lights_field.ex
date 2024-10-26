defmodule Day6.Lightsfield do
  use GenServer

# API

  def start_link(_args, _opts) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def switch_on(server, from, to) do
    GenServer.call(server, {:switch_on, from, to}) 
  end

  def switch_off(server, from, to) do
    GenServer.call(server, {:switch_off, from, to}) 
  end

  def toggle(server, from, to) do
    GenServer.call(server, {:toggle, from, to}) 
  end

  def get_field(server) do
    GenServer.call(server, :get_field)
  end
  
# Internal functions

  @impl true
  def init(_opts) do
    ret = :array.new([{:size, 1000*1000}, {:default,false}]) |> IO.inspect
    {:ok, ret}
  end

  @impl true
  def handle_call({:switch_on, {from_x, from_y}, {to_x, to_y}}, _from, state) do
    new_state = for x <- from_x..to_x, y <- from_y..to_y, reduce: state do
      acc -> 
        :array.set(1000 * y + x, true, acc)
    end
    {:reply, new_state, new_state} 
  end

  @impl true
  def handle_call({:switch_off, {from_x, from_y}, {to_x, to_y}}, _from, state) do
    new_state = for x <- from_x..to_x, y <- from_y..to_y, reduce: state do
      acc -> 
        :array.set(1000 * y + x, false, acc)
    end
    {:reply, new_state, new_state} 
  end

  @impl true
  def handle_call({:toggle, {from_x, from_y}, {to_x, to_y}}, _from, state) do
    new_state = for x <- from_x..to_x, y <- from_y..to_y, reduce: state do 
      acc ->
        :array.set(1000 * y + x, !:array.get(1000 * y + x, acc), acc)
    end
    {:reply, new_state, new_state} 
  end

  @impl true
  def handle_call(:get_field, _from, state) do
    {:reply, state, state}
  end
end
