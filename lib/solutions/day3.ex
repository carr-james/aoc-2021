defmodule Aoc.Day3 do
  def solve(input) do
    report_lines = Enum.map(input, &String.graphemes/1)
    IO.puts("Part 1: #{power_consumption(report_lines)}")
    IO.puts("Part 2: #{life_report_rating(report_lines)}")
  end

  defp life_report_rating(report_lines) do
    oxygen_generator_rating(report_lines, 0) * c02_scrubber_rating(report_lines, 0)
  end

  defp oxygen_generator_rating([rating], _i),
       do: rating
           |> Enum.join()
           |> to_integer
  defp oxygen_generator_rating(report_lines, i) do
    frequencies = frequencies(report_lines)
    most_common = gamma_rate(Enum.at(frequencies, i))
    filtered = Enum.filter(report_lines, fn (line) -> Enum.at(line, i) == most_common end)
    oxygen_generator_rating(filtered, i + 1)
  end

  defp c02_scrubber_rating([rating], _i),
       do: rating
           |> Enum.join()
           |> to_integer
  defp c02_scrubber_rating(report_lines, i) do
    frequencies = frequencies(report_lines)
    least_common = epsilon_rate(Enum.at(frequencies, i))
    filtered = Enum.filter(report_lines, fn (line) -> Enum.at(line, i) == least_common end)
    c02_scrubber_rating(filtered, i + 1)
  end

  defp frequencies(report_lines) do
    report_lines
    |> transpose
    |> Enum.map(&Enum.frequencies/1)
  end

  defp power_consumption(report_lines) do
    frequencies = frequencies(report_lines)
    rate(frequencies, &gamma_rate/1) * rate(frequencies, &epsilon_rate/1)
  end
  defp rate(frequencies, rate_fn) do
    frequencies
    |> Enum.map(&rate_fn.(&1))
    |> Enum.join()
    |> to_integer
  end
  defp gamma_rate(%{"0" => zeros, "1" => ones}) do
    case zeros > ones,
         do: (
           true -> "0";
           false -> "1")
  end
  defp epsilon_rate(%{"0" => zeros, "1" => ones}) do
    case zeros > ones,
         do: (
           true -> "1";
           false -> "0")
  end

  defp to_integer(binary_string) do
    with {:ok, rate} <- Base2.decode2(binary_string) do
      :binary.decode_unsigned(rate)
    end
  end

  # Rotates 2D array clockwise
  defp transpose(array), do: append_row(array, [])

  defp append_row([], result), do: reverse_rows(result, [])
  defp append_row(row_list, result) do
    [first_row | other_rows] = row_list
    new_result = make_column(first_row, result, [])
    append_row(other_rows, new_result)
  end

  defp make_column([], _, new), do: Enum.reverse(new)
  defp make_column(row, [], accumulator) do
    [row_head | row_tail] = row
    make_column(row_tail, [], [[row_head] | accumulator])
  end
  defp make_column(row, result, accumulator) do
    [row_head | row_tail] = row
    [result_head | result_tail] = result
    make_column(row_tail, result_tail, [[row_head | result_head] | accumulator])
  end

  defp reverse_rows([], result), do: Enum.reverse(result)
  defp reverse_rows([first | others], result), do: reverse_rows(others, [Enum.reverse(first) | result])

end
