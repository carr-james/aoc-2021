defmodule Matrix do
  # Rotates 2D array clockwise
  def transpose(array), do: append_row(array, [])

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