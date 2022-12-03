defmodule Advent2022.Day2 do
  use Rustler, crate: "advent_rust", otp_app: :advent2022

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
  def advent_game(input) when is_list(input), do: :erlang.nif_error(:nif_not_loaded)
  def advent_game_part_2(input) when is_list(input), do: :erlang.nif_error(:nif_not_loaded)
end
