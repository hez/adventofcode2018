defmodule AOC do
  def run, do: run(0)

  def run(result) do
    case IO.gets("") do
      :eof -> result
      input ->
        {i, _} = Integer.parse(input)
        run(i + result)
    end
  end
end

IO.puts "result: #{AOC.run()}"
