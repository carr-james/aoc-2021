defmodule Aoc.Day10 do
  def solve(input) do
    Enum.map(input, &String.split(&1, "", trim: true))
    |> Enum.map(&find_corrupted/1)
    |> Enum.filter(fn a -> not Enum.empty?(a) end)
    |> Enum.map(fn [error] -> syntax_error_score_map[error] end)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp find_corrupted(chunks), do: find_corrupted(chunks, Stack.new)
  defp find_corrupted([], _), do: []
  defp find_corrupted([head | tail] = _chunks, stack) do
    case head in openers do
      true ->
        stack = Stack.push(stack, head)
        find_corrupted(tail, stack)
      false ->
        {popped, stack} = Stack.pop(stack)
        case popped == closer_to_opener_map[head] do
          true -> find_corrupted(tail, stack)
          _ -> [head]
        end
    end
  end

  defp openers, do: ["(", "[", "<", "{"]
  defp closers, do: [")", "]", ">", "}"]
  defp opener_to_closer_map, do: Enum.into(Enum.zip(openers(), closers()), %{})
  defp closer_to_opener_map, do: Enum.into(Enum.zip(closers(), openers()), %{})
  defp syntax_error_score_map, do: %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}

end