defmodule Day15.Part2 do

  @amount_ingredients 100
  def amount_ingredients(), do: @amount_ingredients

  def process(input) do
    ingredients = input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [ingr, cap, dur, flav, tex, cal] = Regex.run(~r/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/, line, capture: :all_but_first)
        %{ ingredient: ingr, capacity: elem(Integer.parse(cap), 0), durability: elem(Integer.parse(dur), 0), flavor: elem(Integer.parse(flav), 0), texture: elem(Integer.parse(tex), 0), calories: elem(Integer.parse(cal), 0) }
      end)
      |> IO.inspect

	 props = for a <- 0..amount_ingredients(),
		  b <- 0..amount_ingredients() - a,
        c <- 0..amount_ingredients() - a - b do
      d = amount_ingredients() - a - b - c

      coeffs = {a,b,c,d}

      temp = ingredients
        |> Enum.with_index(fn ingr, idx -> {idx, ingr} end)
        |> Enum.map(fn {idx,ingr} ->
            coeff = elem(coeffs, idx)
            %{ ingr | capacity: coeff * ingr.capacity,
              durability: coeff * ingr.durability,
              flavor: coeff * ingr.flavor,
              texture: coeff * ingr.texture,
              calories: coeff * ingr.calories
            }
          end)
        |> Enum.reduce(%{capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0}, fn ingr, acc ->
          %{capacity: acc.capacity + ingr.capacity,
           durability: acc.durability + ingr.durability,
           flavor: acc.flavor + ingr.flavor,
           texture: acc.texture + ingr.texture,
           calories: acc.calories + ingr.calories
          }
          |> IO.inspect
        end)

        ret = max(0, temp.capacity) * 
          max(0, temp.durability) * 
          max(0, temp.flavor) * 
          max(0, temp.texture)

        if temp.calories === 500 do
          ret
        else
          0
        end
    end
    Enum.max(props)
  end

  def main() do
    # input = """
    # Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
    # Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    # """
    input = File.read!("input.txt")
    result = process(input)
    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
