defmodule DayThree do
  defstruct id: 0,
            origin: {0, 0},
            size: {0, 0}

  @regex ~r/#(?<id>.+) @ (?<xorigin>.+),(?<yorigin>.+): (?<xsize>.+)x(?<ysize>.+)/
  def parse(str) do
    @regex
    |> Regex.named_captures(str)
    |> new()
  end

  defp new(%{"id" => id, "xsize" => xsize, "ysize" => ysize, "xorigin" => xorigin, "yorigin" => yorigin}),
       do: %__MODULE__{id: id, origin: {String.to_integer(xorigin), String.to_integer(yorigin)}, size: {String.to_integer(xsize), String.to_integer(ysize)}}

  def add_to_matrix(%{origin: {xorigin, yorigin}, size: {xsize, ysize}}, matrix) do
    y_range = (yorigin..yorigin + ysize - 1)
    (xorigin..xorigin + xsize - 1)
    |> Enum.reduce(matrix, fn x, x_matrix ->
      Enum.reduce(y_range, x_matrix, fn y, y_matrix ->
        Map.put(y_matrix, {x, y}, Map.get(y_matrix, {x, y}, 0) + 1)
      end)
    end)
  end

  def add_to_matrix(cloth, matrix) do
    cloth
    |> cloth_to_matrix_indexes()
    |> Enum.reduce(matrix, fn i, m ->
      Map.put(m, i, Map.get(m, i, 0) + 1)
    end)
  end

  def unique?(cloth, matrix) do
    cloth
    |> cloth_to_matrix_indexes()
    |> Enum.all?(fn i ->
      case matrix[i] do
        nil -> true
        1 -> true
        _ -> false
      end
    end)
  end

  def cloth_to_matrix_indexes(%{origin: {xorigin, yorigin}, size: {xsize, ysize}}) do
    y_range = (yorigin..yorigin + ysize - 1)
    (xorigin..xorigin + xsize - 1)
    |> Enum.map(fn x ->
      Enum.map(y_range, fn y -> {x, y} end)
    end)
    |> List.flatten
  end

  def puts(matrix, x_size, y_size) do
    (0..x_size - 1)
    |> Enum.each(fn x ->
      (0..y_size - 1)
      |> Enum.map(fn y ->
        matrix[{x, y}]
        |> case do
          nil -> '.'
          val -> Integer.to_string(val)
        end
      end)
      |> IO.puts()
    end)
  end
end

cloths = :stdio
       |> IO.read(:all)
       |> String.split("\n")
       |> Enum.reject(&(&1 == ""))
       |> Enum.map(&DayThree.parse/1)

total_used = Enum.reduce(cloths, %{}, &DayThree.add_to_matrix(&1, &2))

total_used
|> Enum.filter(fn {_, count} -> count > 1 end)
|> Enum.count()
|> IO.inspect(label: "part 1")

cloths
|> Enum.reject(&(not DayThree.unique?(&1, total_used)))
|> IO.inspect(label: "part 2")
