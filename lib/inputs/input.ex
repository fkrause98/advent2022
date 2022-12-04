defmodule Advent2022.Input do
  @advent_inputs File.cwd!() <> "/lib/inputs"
  def get(:day1) do
    path = Path.expand(@advent_inputs <> "/day1.txt")
    {:ok, file} = File.read(path)

    day1_parse(file)
  end

  def get(:day1, :test) do
    path = Path.expand(@advent_inputs <> "/day1_test.txt")
    {:ok, file} = File.read(path)

    day1_parse(file)
  end

  def get(:day2, :test) do
    path = Path.expand(@advent_inputs <> "/day2_test.txt")
    {:ok, file} = File.read(path)
    day2_parse(file)
  end

  def get(:day2) do
    path = Path.expand(@advent_inputs <> "/day2.txt")
    {:ok, file} = File.read(path)
    day2_parse(file)
  end

  def get(:day3, :test) do
    path = Path.expand(@advent_inputs <> "/day3_test.txt")
    {:ok, file} = File.read(path)
    day3_parse(file)
  end

  def get(:day3) do
    path = Path.expand(@advent_inputs <> "/day3.txt")
    {:ok, file} = File.read(path)
    day3_parse(file)
  end

  def get(:day4, :test) do
    path = Path.expand(@advent_inputs <> "/day4_test.txt")
    {:ok, file} = File.read(path)
    day4_parse(file)
  end
  def get(:day4) do
    path = Path.expand(@advent_inputs <> "/day4.txt")
    {:ok, file} = File.read(path)
    day4_parse(file)
  end

  defp day1_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn str -> String.split(str, "\n") |> Enum.map(&String.to_integer/1) end)
  end

  defp day2_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n")
    |> Enum.flat_map(&String.split(&1, " "))
  end

  defp day3_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n")
  end

  defp day4_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn str ->
      [str1, str2] = String.split(str, ",")
      [range_from_str(str1), range_from_str(str2)]
    end)
  end
  defp range_from_str(str) do
    [x, y] = String.split(str, "-")
    do_parse(x)..do_parse(y)
  end

  defp do_parse(int) when is_binary(int) do
    int
    |> Integer.parse()
    |> then(fn {x, ""} -> x end)
  end
end
