defmodule Day13 do
  @part 2

  defp part() do
    @part
  end

  defmodule Pairing do
    defstruct [:person_a, :person_b, :delta]
  end

  def process(input) do
    data = input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [person_a, action, amount, person_b] = Regex.run(~r/(.+) would (.+) (\d+) happiness units by sitting next to (.+)\./, line, capture: :all_but_first)
        %Pairing{ 
          person_a: person_a,
          person_b: person_b,
          delta: case action do
            "gain" -> elem(Integer.parse(amount), 0)
            "lose" -> -1 * elem(Integer.parse(amount), 0)
          end}
      end)

    people = data
      |> Enum.uniq_by(fn e -> e.person_a end)
      |> Enum.map(fn e -> e.person_a end)

    {data, people} = 
        if part() == 2 do
          added = for person <- people, into: [] do
            %Pairing{ person_a: person, person_b: "ic0r", delta: 0 }
          end
          data = added ++ data
          added = for person <- people, into: [] do
            %Pairing{ person_a: "ic0r", person_b: person, delta: 0 }
          end
          data = added ++ data
          people = ["ic0r" | people ]
          {data, people}
        else
          {data, people}
        end

    res = Permutation.permute!(people)
      |> Enum.map(fn permutation ->
        permutation
          |> Enum.chunk_every(2, 1, [hd(permutation)])
          |> Enum.map(fn [name1, name2] ->
            this = Enum.find(data, fn pairing -> pairing.person_a == name1 and pairing.person_b == name2 end)
            other = Enum.find(data, fn pairing -> pairing.person_b == name1 and pairing.person_a == name2 end)
            this.delta + other.delta
          end)
          |> Enum.sum
      end)
      |> Enum.max

    res
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
