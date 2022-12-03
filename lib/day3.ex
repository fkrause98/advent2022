defmodule Advent2022.Day3 do
  def solve_test_input do
    Advent2022.Input.get(:day3, :test)
    |> split_strings
    |> get_chars_in_both_rucksacks()
    |> to_priorites()
  end

  def solve_part_1 do
    Advent2022.Input.get(:day3)
    |> split_strings
    |> get_chars_in_both_rucksacks()
    |> to_priorites()
    |> Enum.sum()
  end

  def solve_part_2_test do
    Advent2022.Input.get(:day3, :test)
    |> Enum.chunk_every(3)
    |> Enum.map(&char_in_three_rucksacks/1)
    |> to_priorites()
    |> Enum.sum()
  end

  def solve_part_2 do
    Advent2022.Input.get(:day3)
    |> Enum.chunk_every(3)
    |> Enum.map(&char_in_three_rucksacks/1)
    |> to_priorites()
    |> Enum.sum()
  end

  defp split_strings(strings) when is_list(strings) do
    strings
    |> Enum.map(&split_string/1)
  end

  defp split_string(string) when is_binary(string) do
    half_indx = Integer.floor_div(String.length(string), 2)
    String.split_at(string, half_indx)
  end

  defp to_priorites(chars) when is_list(chars) do
    Enum.map(chars, &char_to_priority/1)
  end

  defp char_to_priority(char) when is_binary(char) do
    ascii_code = char |> String.to_charlist() |> hd
    is_upper_case? = ascii_code in 65..90

    cond do
      is_upper_case? ->
        rem(ascii_code + 27, 65)

      not is_upper_case? ->
        rem(ascii_code + 1, 97)
    end
  end

  defp get_chars_in_both_rucksacks(strings) when is_list(strings) do
    Enum.map(strings, fn string_pair -> char_in_both_rucksacks(string_pair) end)
  end

  defp char_in_both_rucksacks({str1, str2}) do
    set1 = str1 |> String.graphemes() |> MapSet.new()
    set2 = str2 |> String.graphemes() |> MapSet.new()

    MapSet.intersection(set1, set2)
    |> MapSet.to_list()
    |> hd
  end

  defp char_in_three_rucksacks([str1, str2, str3]) do
    set1 = str1 |> String.graphemes() |> MapSet.new()
    set2 = str2 |> String.graphemes() |> MapSet.new()
    set3 = str3 |> String.graphemes() |> MapSet.new()
    inter = MapSet.intersection(set1, set2)

    MapSet.intersection(inter, set3)
    |> MapSet.to_list()
    |> hd
  end
end
