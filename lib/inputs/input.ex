defmodule Advent.Input do
  @advent_inputs File.cwd! <> "/lib/inputs"
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

  defp day1_parse(file_content) do
    file_content
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn str -> String.split(str, "\n") |> Enum.map(&String.to_integer/1) end)
  end
end
