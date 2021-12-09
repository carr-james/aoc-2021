defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day9.txt")
    Aoc.Day9.solve(input)
  end
end
