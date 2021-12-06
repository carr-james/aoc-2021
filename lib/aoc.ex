defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day6.txt")
    Aoc.Day6.solve(input)
  end
end
