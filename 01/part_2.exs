# 81204
defmodule AOC do
  def run do
    input = IO.read(:stdio, :all)
            |> String.split("\n")
            |> Enum.reject(fn val -> val == "" end)
            |> Enum.map(&String.to_integer/1)
    run(0, %{}, input, input)
  end

  def run(result, seen, cur_input, list) do
    {input, new_input} = List.pop_at(cur_input, 0)
    new_input = case new_input do
                  [] -> list
                  i -> i
                end
    freq = result + input
    freq_count = Map.get(seen, freq, 0) + 1

    case freq_count do
      2 -> freq
      i -> run(freq, Map.put(seen, freq, i), new_input, list)
    end
  end
end

IO.puts "result: #{AOC.run()}"
