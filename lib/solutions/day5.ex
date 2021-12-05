defmodule Aoc.Day5 do
  def solve(input) do
    segments = parse(input)

    Enum.map(segments, &points_between_orthogonal/1)
    |> List.flatten()
    |> dangerous_points()
    |> Enum.count()
    |> IO.inspect(label: "Part 1")

    Enum.map(segments, &points_between/1)
    |> List.flatten()
    |> dangerous_points()
    |> Enum.count()
    |> IO.inspect(label: "Part 2")
  end

  defp dangerous_points(points) do
    Enum.frequencies(points)
    |> Enum.filter(fn ({_, freq}) -> freq >= 2 end)
    |> Enum.map(fn ({point, _}) -> point end)
  end

  defp points_between_orthogonal({{x1, y1}, {x2, y2}} = segment) when (x1 == x2) or (y1 == y2), do: points_between(segment)
  defp points_between_orthogonal({{_x1, _y1}, {_x2, _y2}}), do: []

  defp points_between({{x1, y1}, {x2, y2}}) do
    x_points = Enum.to_list(x1..x2)
    y_points = Enum.to_list(y1..y2)
    case length(x_points) == length(y_points) do
      true -> Enum.zip(x_points, y_points)
      false -> for x <- x_points, y <- y_points, do: {x, y}
    end
  end

  defp parse(lines) do
    Enum.map(lines, &parse_line/1)
  end

  defp parse_line(line) do
    [x1, y1, x2, y2] = Regex.run(~r/(\d+),(\d+) -> (\d+),(\d+)/, line, capture: :all_but_first)
                       |> Enum.map(&String.to_integer/1)
    {{x1, y1}, {x2, y2}}
  end
end