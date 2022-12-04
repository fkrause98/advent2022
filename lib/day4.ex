defmodule Advent2022.Day4 do
  def solve_test_input_part1 do
    Advent2022.Input.get(:day4, :test)
    |> Enum.filter(fn [range_1, range_2] -> range_1 <~> range_2 or range_2 <~> range_1 end)
    |> Enum.count()
  end

  def solve_input_part1 do
    Advent2022.Input.get(:day4)
    |> Enum.filter(fn [range_1, range_2] -> range_1 <~> range_2 or range_2 <~> range_1 end)
    |> Enum.count()
  end

  def range_1 <~> range_2, do: range_overlaps(range_1, range_2)

  defp range_overlaps(%Range{first: x_1, last: y_1}, %Range{first: x_2, last: y_2}) do
    x_1 >= x_2 and y_1 <= y_2
  end

  def solve_test_input_part2 do
    Advent2022.Input.get(:day4, :test)
    |> Enum.reject(fn [range_1, range_2] -> Range.disjoint?(range_1, range_2) end)
    |> Enum.count()
  end

  def solve_input_part2 do
    Advent2022.Input.get(:day4)
    |> Enum.reject(fn [range_1, range_2] -> Range.disjoint?(range_1, range_2) end)
    |> Enum.count()
  end
end
