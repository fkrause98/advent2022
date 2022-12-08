defmodule Advent2022.Day2 do
  import Advent2022.Native
  def solve_test_input do
    Advent2022.Input.get(:day2, :test)
    |> advent_game()
  end

  def solve_input do
    Advent2022.Input.get(:day2)
    |> advent_game()
  end

  def solve_test_input_part_2 do
    Advent2022.Input.get(:day2, :test)
    |> advent_game_part_2()
  end

  def solve_input_part_2 do
    Advent2022.Input.get(:day2)
    |> advent_game_part_2()
  end
end
