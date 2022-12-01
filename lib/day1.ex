defmodule Advent2022.Day1 do
  def solve_test_input do
    Advent.Input.get(:day1, :test)
    |> Enum.with_index(fn elf_calories, indx -> {indx, Enum.sum(elf_calories)} end)
    |> Enum.max_by(fn {_, calories} -> calories end)
  end

  def solve_input do
    Advent.Input.get(:day1)
    |> Enum.with_index(fn elf_calories, indx -> {indx, Enum.sum(elf_calories)} end)
    |> Enum.max_by(fn {_, calories} -> calories end)
  end

  def solve_extra do
    Advent.Input.get(:day1)
    |> Enum.with_index(fn elf_calories, indx -> {indx, Enum.sum(elf_calories)} end)
    |> Enum.sort(fn {_, c_x}, {_, c_y} -> c_x > c_y end)
    |> Enum.take(3)
    |> Enum.map(fn {elf, calories} -> calories end)
    |> Enum.sum()
  end
end
