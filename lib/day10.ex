defmodule Advent2022.Day10 do
  def solve_part_1 do
    {:ok, file_string} = Advent2022.Input.get(:day10)

    Enum.map(
      [20, 60, 100, 140, 180, 220],
      fn cycle_count ->
        reg_x_value =
        file_string
        |> String.trim
        |> String.split("\n")
        |> Advent2022.Native.advent_day_10(cycle_count)
        reg_x_value * cycle_count
      end
    )
    |> Enum.sum()
  end
end
