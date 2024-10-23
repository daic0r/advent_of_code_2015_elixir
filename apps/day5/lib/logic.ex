defmodule Day5.Logic do
  def is_vowel?(<<ch>>) when ch in [?a, ?e, ?i, ?o, ?u] do
    true
  end
  def is_vowel?(<<_ch>>) do
    false
  end

  def has_disallowed_pair?(str) when is_binary(str) do
    String.contains?(str, "ab")
    or String.contains?(str, "cd")
    or String.contains?(str, "pq")
    or String.contains?(str, "xy")
  end

  def has_double_letter(str) do
    str
    |> String.graphemes
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.with_index(fn elem, index -> {index, elem} end)
    |> Enum.map(fn {idx_1, [a, b]} -> {a == b, a <> b, idx_1} end)
    |> Enum.reduce_while(false, fn {same, pair, idx}, _acc -> 
      if same do
        {:halt, {:found, {pair, idx}}}
      else
        {:cont, false}
      end
    end)

  end

  def has_3_vowels?(str) do
    num_vowels = str |> String.graphemes |> Enum.reduce_while(0, fn x, acc ->
      ret = if is_vowel?(x) do
        acc + 1
      else
        acc
      end
      if ret == 3 do
        {:halt, ret}
      else
        {:cont, ret}
      end
    end)

    num_vowels == 3
  end

  def has_2_letter_pairs?(str) do
    str
      |> String.graphemes
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.with_index(fn [a,b], index -> {index, a <> b} end)
      |> Enum.reduce_while(false, fn {idx,pair}, _acc ->
        again = str |> String.slice(idx+2..-1//1) |> String.contains?(pair)
        if again do
          {:halt, true}
        else
          {:cont, false}
        end
      end)
  end

  def is_nice_part_1?(str) do
    a = not has_disallowed_pair?(str) and has_3_vowels?(str)
    if a do
      case has_double_letter(str) do
        {:found, _pair} -> true
        false -> false
      end
    end
  end

  def is_nice_part_2?(str) do
    case has_2_letter_pairs?(str) do
      true ->
        String.match?(str, ~r/([a-z]).\1/)
      _ -> false
    end
  end
end
