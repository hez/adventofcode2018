input = :stdio
        |> IO.read(:all)
        |> String.trim()
        |> String.split("\n")

Enum.find(input, fn i ->
  Enum.find(input, fn j ->
    diff = String.myers_difference(i, j)
    if diff |> Keyword.get_values(:del) |> List.to_string() |> String.length() == 1 do
      IO.puts i
      IO.puts j

      diff
      |> Keyword.get_values(:eq)
      |> List.to_string()
      |> IO.puts

      true
    else
      false
    end
  end)
end)
