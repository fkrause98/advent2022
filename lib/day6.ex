defmodule Advent2022.Day6 do
  defmodule Part1 do
    def solve_test_inputs_part_1 do
      Advent2022.Input.get(:day6, :test)
      |> Enum.map(&solve_test_input_part_1/1)
    end

    def solve_test_input_part_1(test) do
      test
      |> String.to_charlist()
      |> generate_possible_markers()
      |> Enum.find_index(&is_marker/1)
      |> Kernel.+(4)
    end

    def solve_part_1 do
      Advent2022.Input.get(:day6)
      |> String.to_charlist()
      |> generate_possible_markers()
      |> Enum.find_index(&is_marker/1)
      |> Kernel.+(4)
    end

    def is_marker(list), do: Enum.uniq(list) == list

    def generate_possible_markers(str) when is_list(str) do
      generate_possible_markers(str, [])
    end

    defp generate_possible_markers(str = [a, b, c, d | _], acum) do
      generate_possible_markers(tl(str), [[a, b, c, d] | acum])
    end

    defp generate_possible_markers(_, acum), do: Enum.reverse(acum)
  end

  defmodule Part2 do
    def solve_test_inputs do
      Advent2022.Input.get(:day6, :test)
      |> Enum.map(&solve_test_input/1)
    end

    def solve_test_input(test) do
      test
      |> String.to_charlist()
      |> generate_possible_markers()
      |> Enum.find_index(&is_marker/1)
      |> Kernel.+(14)
    end

    def solve do
      Advent2022.Input.get(:day6)
      |> String.to_charlist()
      |> generate_possible_markers()
      |> Enum.find_index(&is_marker/1)
      |> Kernel.+(14)
    end

    def is_marker(list), do: Enum.uniq(list) == list

    def generate_possible_markers(str) when is_list(str) do
      generate_possible_markers(str, [])
    end

    defp generate_possible_markers(str = [_ | tail], acum) when length(str) >= 14 do
      possible_marker = Enum.take(str, 14)
      generate_possible_markers(tail, [possible_marker | acum])
    end

    defp generate_possible_markers(_, acum), do: Enum.reverse(acum)
  end
end
