defmodule Day10.Part1 do

  # def find_runlength(<<ch, str::binary>>, <<compare_ch>>, cnt, list) when ch == compare_ch do
  #   find_runlength(str, <<compare_ch>>, cnt + 1, list) 
  # end
  # def find_runlength(<<>>, <<compare_ch>>, cnt, list) do
  #   list = [{cnt, <<compare_ch>>} | list]
  #   list
  # end
  # def find_runlength(<<ch, str::binary>>, <<compare_ch>>, cnt, list) do
  #   list = [{cnt, <<compare_ch>>} | list]
  #   find_runlength(<<ch>> <>  str, <<ch>>, 0, list)
  # end

  def process(input, cnt) when cnt < 50 do
    # ret = find_runlength(input, String.at(input, 0), 0, [])
    # str = ret
    #   |> Enum.map(fn {cnt, ch} -> Integer.to_string(cnt) <> ch end)
    #   |> Enum.reduce("", fn str, acc -> str <> acc end)
    #
    # IO.puts "Round #{cnt}"

    # process(str, cnt + 1)

    matches = Regex.scan(~r/(\d)(\1*)/, input, capture: :all_but_first)
    result = matches
      |> Enum.map(fn [digit, reps] -> Integer.to_string(String.length(reps) + 1) <> digit end)
      |> Enum.reduce("", fn str, acc -> acc <> str end)
    process(result, cnt + 1) 
  end
  def process(input, _cnt) do
    input 
  end
  def main() do
    result = process("1321131112", 0)

    IO.puts "Result = #{String.length(result)}"
  end
 
  def start_link do
    main() 
    {:ok, self()}
  end
end
