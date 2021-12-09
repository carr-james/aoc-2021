defmodule Aoc.Day9 do
  def solve(input) do
    input = Enum.map(input, fn (line) -> Enum.map(String.split(line, "", trim: true), &String.to_integer/1) end)
    width = length(Enum.at(input, 0))
    height = length(input)
    padding = 0..width + 2
              |> Enum.map(fn _ -> 10 end)
    padded = [padding] ++ Enum.map(input, fn row -> [10] ++ row ++ [10] end) ++ [padding]
    grid_list = Enum.map(0..((width * height) - 1), fn (i) -> {rem(i, width) + 1, trunc(i / width) + 1} end)
                |> Enum.map(&find_at_with_adjacents(&1, padded))
    low_points = Enum.filter(grid_list, fn ({_, it, adjacents}) -> Enum.all?(adjacents, fn adj -> adj > it end) end)

    Enum.map(low_points, fn {_, low_point, _} -> low_point + 1 end)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

    grid_map = Enum.group_by(grid_list, fn {pos, _, _} -> pos end)
    Enum.map(low_points, &basin_size(&1, grid_map))
    |> Enum.map(fn {size, _} -> size + 1 end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(fn acc, it -> acc * it end)
    |> IO.inspect(label: "Part 2")

  end

  defp basin_size({{x, y} = current, height, [u, d, l, r]}, grid_map)
       when (u < 9) or
            (d < 9) or
            (l < 9) or
            (r < 9) do
    grid_map = Map.drop(grid_map, [current])

    {up, grid_map} = case height < u and u < 9 and Map.has_key?(grid_map, {x, y - 1}) do
      true ->
        {acc, grid} = basin_size(Enum.at(Map.get(grid_map, {x, y - 1}), 0), grid_map)
        {acc + 1, grid}
      false -> {0, grid_map}
    end
    {down, grid_map} = case height < d and d < 9 and Map.has_key?(grid_map, {x, y + 1}) do
      true ->
        {acc, grid} = basin_size(Enum.at(Map.get(grid_map, {x, y + 1}), 0), grid_map)
        {acc + 1, grid}
      false -> {0, grid_map}
    end
    {left, grid_map} = case height < l and l < 9 and Map.has_key?(grid_map, {x - 1, y}) do
      true ->
        {acc, grid} = basin_size(Enum.at(Map.get(grid_map, {x - 1, y}), 0), grid_map)
        {acc + 1, grid}
      false -> {0, grid_map}
    end
    {right, grid_map} = case height < r and r < 9 and Map.has_key?(grid_map, {x + 1, y}) do
      true ->
        {acc, grid} = basin_size(Enum.at(Map.get(grid_map, {x + 1, y}), 0), grid_map)
        {acc + 1, grid}
      false -> {0, grid_map}
    end
    {up + down + left + right, grid_map}
  end
  defp basin_size({{_x, _y}, _h, [_u, _d, _l, _r]}, grid_map) do
    {0, grid_map}
  end

  defp find_at_with_adjacents({x, y} = point, grid) do
    this = Enum.at(Enum.at(grid, y), x)
    up = Enum.at(Enum.at(grid, y - 1), x)
    down = Enum.at(Enum.at(grid, y + 1), x)
    left = Enum.at(Enum.at(grid, y), x - 1)
    right = Enum.at(Enum.at(grid, y), x + 1)
    {point, this, [up, down, left, right]}
  end

end