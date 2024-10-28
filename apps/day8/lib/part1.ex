defmodule Day8.Part1  do
  def process(input) do
    lines = input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim/1)

    total_chars_cnt = lines
      |> Enum.reduce(0, fn x, acc -> acc + String.length(x) end)

    escaped_cnt = lines 
      |> Enum.reduce(0, fn x, acc ->
        {x, _} = Code.eval_string(x)
        # x = String.slice(x, 1..String.length(x)-2)
        # x = String.replace(x, ~S(\"), ~S("))
        # x = String.replace(x, "\\\\", "\\")
        # x = Regex.replace(~r/\\x([a-f0-9]{2})/, x, "X", global: true)
        acc + String.length(x)
      end)

    IO.puts "#{total_chars_cnt} - #{escaped_cnt}"
    total_chars_cnt - escaped_cnt
  end
  def main do
    input = File.read!("input.txt")
    result = process(input)

    IO.puts "Result = #{result}"
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
