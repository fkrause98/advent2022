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

  def get(:day6, :test) do
    [
      "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
      "bvwbjplbgvbhsrlpgdmjqwftvncz",
      "nppdvjthqldpwncqszvftbrmjlhg",
      "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
      "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    ]
  end

  def get(:day6) do
    path = Path.expand(@advent_inputs <> "/day6.txt")
    {:ok, file} = File.read(path)
    file |> String.split("\n") |> hd
  end

  def get(:day7, :test) do
    path = Path.expand(@advent_inputs <> "/day7_test.txt")
    {:ok, file} = File.read(path)
    day7_parse(file)
  end

  def get(:day7) do
    path = Path.expand(@advent_inputs <> "/day7.txt")
    {:ok, file} = File.read(path)
    day7_parse(file)
  end

  def get(:day8, :test) do
    path = Path.expand(@advent_inputs <> "/day8_test.txt")
    {:ok, file} = File.read(path)
    day8_parse(file)
  end

  def get(:day8) do
    path = Path.expand(@advent_inputs <> "/day8.txt")
    {:ok, file} = File.read(path)
    day8_parse(file)
  end

  def get(:day10) do
    path = Path.expand(@advent_inputs <> "/day10.txt")
    {:ok, file} = File.read(path)
  end

  defp day8_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  defp day7_parse(file_content) do
    String.split(file_content, "\n")
    |> Enum.reject(&(&1 == ""))
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
