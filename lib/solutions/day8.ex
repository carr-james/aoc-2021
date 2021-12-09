defmodule Aoc.Day8 do
  def solve(input) do
    lines = parse(input)

    Enum.map(lines, fn {_signal_pattens, output_patterns} -> output_patterns end)
    |> Enum.map(&count_segments/1)
    |> Enum.map(fn (segment_counts) -> Enum.filter(segment_counts, fn c -> c in [2, 3, 4, 7] end)  end)
    |> Enum.map(&length/1)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

#    Enum.map(
#      lines,
#      fn ({signal_patterns, output}) ->
#        calc_mapping(signal_patterns)
#        #        |> decode_output(output)
#      end
#    )
#    #    |> Enum.sum()
#    |> IO.inspect(label: "Part 2")

    calc_mapping(["acedgfb","cdfbe","gcdfa","fbcad","dab","cefabd","cdfgeb","eafb","cagedb","ab"])

    decode_output(
      %{
        sort_string("acedgfb") => 8,
        sort_string("cdfbe") => 5,
        sort_string("gcdfa") => 2,
        sort_string("fbcad") => 3,
        sort_string("dab") => 7,
        sort_string("cefabd") => 9,
        sort_string("cdfgeb") => 6,
        sort_string("eafb") => 4,
        sort_string("cagedb") => 0,
        sort_string("ab") => 1
      },
      ["cdfeb", "fcadb", "cdfeb", "cdbaf"]
    )
  end


  defp calc_mapping(signal_patterns) do
    sorted = Enum.map(signal_patterns, &sort_string/1)
    [one] = Enum.filter(sorted, fn (s) -> String.length(s) == 2 end)
    [four] = Enum.filter(sorted, fn (s) -> String.length(s) == 4 end)
    [seven] = Enum.filter(sorted, fn (s) -> String.length(s) == 3 end)
    [eight] = Enum.filter(sorted, fn (s) -> String.length(s) == 7 end)
    six_nine_zero = Enum.filter(sorted, fn (s) -> String.length(s) == 6 end)
    two_three_five = Enum.filter(sorted, fn (s) -> String.length(s) == 5 end)

    top_seg = subtract_string(seven, one)
    botleft_bot = subtract_string(subtract_string(eight, four), top_seg)
    seven_inverted = subtract_string(eight, seven)

    IO.inspect(one, label: "one")
    IO.inspect(four, label: "four")
    IO.inspect(seven, label: "seven")
    IO.inspect(eight, label: "eight")
    IO.inspect(top_seg, label: "top")
    IO.inspect(six_nine_zero, label: "six nine zero")
    IO.inspect(two_three_five, label: "two three five")
    IO.inspect(botleft_bot, label: "bot-left bot")
    IO.inspect(seven_inverted, label: "seven-inverted")


  end

  defp decode_output(pattern_to_digit_map, output_patterns) do
    Enum.map(output_patterns, fn p -> Map.get(pattern_to_digit_map, sort_string(p)) end)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> String.to_integer()
  end

  defp count_segments(pattern) do
    Enum.map(pattern, fn (segment) -> String.length(segment) end)
  end

  defp subtract_string(s1, s2) do
    l1 = String.split(s1, "", trim: true)
    l2 = String.split(s2, "", trim: true)
    Enum.join(l1 -- l2)
  end

  defp sort_string(s) do
    String.split(s, "", trim: true)
    |> Enum.sort()
    |> Enum.join()
  end

  defp parse(lines) do
    Enum.map(lines, &String.split(&1, " | "))
    |> Enum.map(
         fn ([signal_patterns, output]) -> {
                                             String.split(signal_patterns, " "),
                                             String.split(output, " ")
                                           }
         end
       )
  end
end