defmodule Aoc.Day2 do
  def solve(input) do
    {y, x} = handle_commands({0, 0}, input)
    IO.puts("Part 1: #{y * x}")
    {y, x, _aim} = handle_commands({0, 0, 0}, input)
    IO.puts("Part 2: #{y * x}")
  end

  defp handle_commands(position, []), do: position
  defp handle_commands(position, [command | commands]) do
    handle_command(position, parse_command(command))
    |> handle_commands(commands)
  end

  defp handle_command({y, x}, {"forward", dt}), do: {y, x + dt}
  defp handle_command({y, x}, {"up", dt}), do: {y - dt, x}
  defp handle_command({y, x}, {"down", dt}), do: {y + dt, x}
  defp handle_command({y, x, aim}, {"forward", dt}), do: {y + (aim * dt), x + dt, aim}
  defp handle_command({y, x, aim}, {"up", dt}), do: {y, x, aim - dt}
  defp handle_command({y, x, aim}, {"down", dt}), do: {y, x, aim + dt}

  defp parse_command(command) do
    [operator, dt] = String.split(command, " ")
    dt = String.to_integer(dt)
    {operator, dt}
  end
end
