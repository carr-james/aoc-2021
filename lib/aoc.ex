defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day10.txt")
    Aoc.Day10.solve(input)
  end
end
