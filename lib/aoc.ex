defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day8-example.txt")
    Aoc.Day8.solve(input)
  end
end
