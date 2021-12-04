defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day3.txt")
    Aoc.Day3.solve(input)
  end
end
