defmodule Day16 do
  @part 2

  defmodule Day16.Parameters do
    defstruct [:children, :cats, :samoyeds, :pomeranians, :akitas, :vizslas,
      :goldfish, :trees, :cars, :perfumes]
  end

  defmacro part() do
    @part
  end

  def process(input) do
    alias Day16.Parameters
# Sue 484: pomeranians: 1, samoyeds: 1, perfumes: 3
    # children: 3
    # cats: 7
    # samoyeds: 2
    # pomeranians: 3
    # akitas: 0
    # vizslas: 0
    # goldfish: 5
    # trees: 3
    # cars: 2
    # perfumes: 1
    reference = %Parameters {
      children: 3,
      cats: 7,
      samoyeds: 2,
      pomeranians: 3,
      akitas: 0,
      vizslas: 0,
      goldfish: 5,
      trees: 3,
      cars: 2,
      perfumes: 1
    }
    aunts = input
      |> String.split("\n", trim: true)
      |> Enum.with_index(fn line, idx -> {idx+1, line} end)
      |> Enum.map(fn {idx, line} ->
        params = Regex.scan(~r/(\w+): (\d+)(, )?/, line, capture: :all_but_first)
        struct = params
          |> Enum.map(fn data_list ->
              tup = List.to_tuple(data_list)
              {String.to_existing_atom(elem(tup, 0)), elem(tup, 1) |> Integer.parse |> elem(0)}
            end)
          |> Enum.reduce(%Day16.Parameters{}, fn x, acc ->
            Map.put(acc, elem(x, 0), elem(x, 1))
          end)
        {idx, struct} 
      end)
    
    aunt = aunts
      |> Enum.find(fn {_idx, aunt} ->
        aunt
          |> Map.keys
          |> Enum.reduce(true,
            fn key, acc ->
              aunt_val = Map.get(aunt, key)
              ref_val = Map.get(reference, key)
              acc and (is_nil(aunt_val) or case part() do
                1 ->
                  aunt_val === ref_val
                2 -> case key do
                    param when param === :cats or param === :trees ->
                      aunt_val > ref_val
                    param when param === :pomeranians or param === :goldfish ->
                      aunt_val < ref_val
                    _ -> aunt_val === ref_val
                  end
            end)
          end)
      end)
      |> IO.inspect

    elem(aunt, 0)
  end

  def main() do
    input = File.read!("input.txt")
    result = process(input)
    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
