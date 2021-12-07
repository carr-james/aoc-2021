defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day7.txt")
    Aoc.Day7.solve(input)
  end
end
