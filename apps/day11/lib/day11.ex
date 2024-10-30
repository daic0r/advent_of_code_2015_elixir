defmodule Day11 do
  def inc_letter(letter) do
    case letter do
      ch when ch in ?a..?y -> {:ok, <<ch + 1>>}
      ?z -> :carry
    end 
  end

  def inc_password("") do
    "a"
  end
  def inc_password(rev_pw) do
    <<ch, rest::binary>> = rev_pw 
    case inc_letter(ch) do
      {:ok, new_ch} -> new_ch <> rest
      :carry -> "a" <> inc_password(rest)
    end
  end

  def has_3_letter_straight?(str) do
    str
      |> String.to_charlist
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.reduce_while(false, fn [c,b,a], _acc ->
        ret = (c == b + 1) and (c == a + 2)
        case ret do
          true -> {:halt, true}
          false -> {:cont, false}
        end
      end)
  end

  def has_iol?(str) do
    String.contains?(str, "i") or String.contains?(str, "o") or String.contains?(str, "l")
  end

  def has_2_non_overlapping_pairs?(str) do
    case Regex.scan(~r/([a-z])\1/, str, capture: :all_but_first) do
      [[a], [b]] -> a != b
      _ -> false
    end
  end

  def is_valid_password?(str) do
    has_3_letter_straight?(str) and not has_iol?(str) and has_2_non_overlapping_pairs?(str)
  end
     
  def process(input) do
    case is_valid_password?(input) do
      true -> input
      false -> process(inc_password(input))
    end 
  end

  def main do
    input = "vzbxkghb"
    result = input
      |> String.reverse
      |> process
      |> String.reverse
      

    IO.puts "Part 1 Result = #{result}"

    result = result
      |> String.reverse
      |> inc_password
      |> process
      |> String.reverse

    IO.puts "Part 2 Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
