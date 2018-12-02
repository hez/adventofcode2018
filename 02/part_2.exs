defmodule CharArray do
  def to_pos_char(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {val, index} -> val * index + 1 end)
  end

  def to_charlist(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {val, index} -> val / index + 1 end)
  end
end

input = :stdio
        |> IO.read(:all)
        |> String.split("\n")
        |> Enum.reject(&(&1 == ""))
        |> Enum.map(&String.to_charlist/1)

input
|> Enum.find(fn i ->
  i_arr = CharArray.to_pos_char(i)
  Enum.find(input, fn j ->
    j_arr = CharArray.to_pos_char(j)
    diff = j_arr -- i_arr
    if Enum.count(diff) == 1 do
      IO.puts j
      true
    else
      false
    end
  end)
end)
|> IO.puts()
