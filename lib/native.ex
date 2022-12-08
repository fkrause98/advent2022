defmodule Advent2022.Native do
  use Rustler, crate: "advent_rust", otp_app: :advent2022, cargo: {:system, "+nightly"}
  def advent_game(input) when is_list(input), do: :erlang.nif_error(:nif_not_loaded)
  def advent_game_part_2(input) when is_list(input), do: :erlang.nif_error(:nif_not_loaded)
  def advent_forest(input) when is_list(input), do: :erlang.nif_error(:nif_not_loaded)
end
