defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day5.txt")
    Aoc.Day5.solve(input)
  end
end
