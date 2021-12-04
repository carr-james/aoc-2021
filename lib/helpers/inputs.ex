defmodule Aoc.Input do
  def get_lines(file) do
    {:ok, text} = File.read(file)
    input = text
            |> String.split("\n", trim: true)
  end
end
