defmodule Aoc.Day7 do
  def solve([input]) do
    crabs =
      String.split(input, ",")
      |> Enum.map(&String.to_integer/1)

    median = median(crabs)
    Enum.map(crabs, fn (crab) -> abs(crab - median) end)
    |> Enum.sum()
    |> trunc
    |> IO.inspect(label: "Part 1")

    mean = trunc(mean(crabs))
    Enum.map(crabs, fn (crab) -> triangle_number(abs(crab - mean)) end)
    |> Enum.sum()
    |> trunc
    |> IO.inspect(label: "Part 2")
  end

  defp median(list) do
    midpoint =
      (length(list) / 2)
      |> Float.floor()
      |> round

    {l1, l2} =
      Enum.sort(list)
      |> Enum.split(midpoint)

    case length(l2) > length(l1) do
      true ->
        [med | _] = l2
        med
      false ->
        [m1 | _] = l2
        [m2 | _] = Enum.reverse(l1)
        mean([m1, m2])
    end
  end

  def mean(list) when is_list(list), do: do_mean(list, 0, 0)
  defp do_mean([], 0, 0), do: nil
  defp do_mean([], t, l), do: t / l
  defp do_mean([x | xs], t, l) do
    do_mean(xs, t + x, l + 1)
  end

  defp triangle_number(n) do
    (n * (n + 1)) / 2
  end
end