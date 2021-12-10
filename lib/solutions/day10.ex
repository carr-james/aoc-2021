defmodule Aoc.Day10 do
  def solve(input) do
    lines = Enum.map(input, &String.split(&1, "", trim: true))
    Enum.map(lines, &find_corrupted/1)
    |> Enum.filter(fn a -> not Enum.empty?(a) end)
    |> Enum.map(fn [error] -> syntax_error_score_map()[error] end)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

    incomplete_lines = Enum.filter(lines, &incomplete?/1)
    Enum.map(incomplete_lines, &auto_complete/1)
    |> Enum.map(&autocomplete_score/1)
    |> Enum.sort()
    |> Enum.drop(trunc(length(incomplete_lines) / 2))
    |> Enum.at(0)
    |> IO.inspect(label: "Part 2")
  end

  defp autocomplete_score(completion) do
    Enum.reduce(completion, 0, fn (i, acc) -> (acc * 5) + autocomplete_score_map()[i] end)
  end

  defp auto_complete(line) do
    Enum.reduce(
      line,
      Stack.new(),
      fn (i, stack) ->
        case i in openers() do
          true -> stack = Stack.push(stack, i)
                  stack
          false -> {_, stack} = Stack.pop(stack)
                   stack
        end
      end
    )
    |> close_all_chunks([])
  end

  defp close_all_chunks(stack, to_close) do
    {top, stack} = Stack.pop(stack)
    if top == nil do
      to_close
      |> Enum.map(fn i -> opener_to_closer_map()[i] end)
      |> Enum.reverse()
    else
      close_all_chunks(stack, [top | to_close])
    end
  end

  defp incomplete?(chunks), do: Enum.empty?(find_corrupted(chunks))

  defp find_corrupted(chunks), do: find_corrupted(chunks, Stack.new)
  defp find_corrupted([], _), do: []
  defp find_corrupted([head | tail] = _chunks, stack) do
    case head in openers() do
      true ->
        stack = Stack.push(stack, head)
        find_corrupted(tail, stack)
      false ->
        {popped, stack} = Stack.pop(stack)
        case popped == closer_to_opener_map()[head] do
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
  defp autocomplete_score_map, do: %{")" => 1, "]" => 2, "}" => 3, ">" => 4}

end