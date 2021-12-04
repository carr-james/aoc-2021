defmodule Aoc do
  def main(_args \\ []) do
    input = Aoc.Input.get_lines("input/day4.txt")
    Aoc.Day4.solve(input)
  end
end
