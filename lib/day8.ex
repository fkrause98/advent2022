defmodule Advent2022.Day8 do
  import Advent2022.Native

  def solve_part_1_test do
    Advent2022.Input.get(:day8, :test)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> advent_forest()
  end

  def solve_part_1 do
    Advent2022.Input.get(:day8)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> advent_forest()
  end
end
