defmodule Day4.Part1 do

  def process(input, num) do
    hash = :crypto.hash(:md5, input <> Integer.to_string(num)) |> Base.encode16
    case String.slice(hash, 0..5) do
      "000000" -> num 
      _ -> process(input, num + 1)
    end
  end

  def main() do
    input = "iwrupvqb" 
    result = process(input, 0)

    IO.puts("Result = #{result}")
  end

  def start_link do
    main()
    {:ok, self()}
  end
end
