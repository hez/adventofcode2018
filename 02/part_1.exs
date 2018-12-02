:stdio
|> IO.read(:all)
|> String.split("\n")
|> Enum.reject(&(&1 == ""))
|> Enum.map(fn str ->
  str
  |> String.to_charlist()
  |> Enum.map_reduce(%{}, fn char, counts ->
    {true, Map.put(counts, char, Map.get(counts, char, 0) + 1)}
  end)
  |> elem(1)
end)
|> Enum.map(fn counts ->
  Enum.map_reduce(counts, {0, 0}, fn
    {_, 2}, t -> {true, {1, elem(t, 1)}}
    {_, 3}, t -> {true, {elem(t, 0), 1}}
    _, t -> {true, t}
  end)
  |> elem(1)
end)
|> Enum.map_reduce({0, 0}, fn {twos, threes}, totals ->
    {true, {elem(totals, 0) + twos, elem(totals, 1) + threes}}
end)
|> elem(1)
|> (fn {ones, twos} -> ones * twos end).()
|> IO.inspect(label: "")
