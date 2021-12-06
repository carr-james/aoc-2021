defmodule Aoc.Day6 do
  def solve([input]) do
    frequencies = String.split(input, ",")
                  |> Enum.map(&String.to_integer/1)
                  |> Enum.frequencies()

    simulate_days_until(frequencies, 80)
    |> count_fish
    |> IO.inspect(label: "Part 1")

    simulate_days_until(frequencies, 256)
    |> count_fish
    |> IO.inspect(label: "Part 2")
  end

  defp simulate_days_until(frequencies, days), do: simulate_days_until(frequencies, days, 0)
  defp simulate_days_until(frequencies, days, days_simulated) when days == days_simulated, do: frequencies
  defp simulate_days_until(frequencies, days, days_simulated) do
    Enum.map(frequencies, &age_fish_one_year/1)
    |> List.flatten()
    |> merge_duplicates
    |> simulate_days_until(days, days_simulated + 1)
  end

  defp merge_duplicates(frequencies) do
    Enum.group_by(frequencies, fn {age, freq} -> age end)
    |> Enum.map(fn {age, list} -> {age, Enum.sum(Enum.map(list, fn ({_, f}) -> f end))} end)
  end

  defp age_fish_one_year({0, freq}), do: [{6, freq}, {8, freq}]
  defp age_fish_one_year({age, freq}), do: [{age - 1, freq}]

  defp count_fish(frequencies), do: Enum.sum(Enum.map(frequencies, fn ({_, f}) -> f end))
end