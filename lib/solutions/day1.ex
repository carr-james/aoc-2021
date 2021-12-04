defmodule Aoc.Day1 do
  def solve(input) do
    integers(input)
    |> count_increasing_adjacent_elements
    |> IO.puts()

    integers(input)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> count_increasing_adjacent_elements
    |> IO.puts()
  end

  defp count_increasing_adjacent_elements(enum) do
    enum
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  defp integers(strings),
       do: strings
           |> Enum.map(&String.to_integer/1)
end
