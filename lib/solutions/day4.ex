defmodule Aoc.Day4 do
  def solve(input) do
    {numbers, boards} = parse(input)
    {played, winner} = find_winner([], numbers, boards)
    IO.puts("Part 1: #{List.last(played) * sum_remaining(played, winner)}")

    {played, loser} = find_loser(numbers, boards)
    IO.puts("Part 2: #{List.last(played) * sum_remaining(played, loser)}")
  end

  defp find_loser(numbers, boards) do
    Enum.map(boards, &find_winner([], numbers, [&1]))
    |> Enum.max_by(fn ({played, _b}) -> played end)
  end

  defp find_winner(played, [], boards), do: {Enum.reverse(played), Enum.filter(boards, &is_bingo(played, &1))}
  defp find_winner(played, [next | remaining], boards) do
    case Enum.filter(boards, &is_bingo(played, &1)) do
      [] -> find_winner([next | played], remaining, boards)
      [bingo] -> {Enum.reverse(played), bingo}
    end
  end

  defp is_bingo(numbers, board) do
    board ++ Matrix.transpose(board)
    |> remove_numbers(numbers)
    |> Enum.any?(fn (x) -> length(x) == 0 end)
  end

  defp sum_remaining(played, board) do
    remove_numbers(board, played)
    |> List.flatten()
    |> Enum.sum()
  end

  defp remove_numbers(lists, numbers) do
    Enum.map(lists, fn (list) -> Enum.reject(list, fn i -> i in numbers end) end)
  end

  defp parse([numbers_string | boards_lines]) do
    numbers = String.split(numbers_string, ",")
              |> Enum.map(&String.to_integer/1)
    boards = boards_lines
             |> Enum.map(&parse_boards/1)
             |> Enum.chunk_every(5)
    {numbers, boards}
  end

  defp parse_boards(line) do
    String.split(line, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

end