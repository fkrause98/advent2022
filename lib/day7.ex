defmodule Advent2022.Day7 do
  def solve_test_input do
    Advent2022.Input.get(:day7, :test)
    |> read_lines()
    |> Map.values()
    |> List.flatten()
    |> Enum.sum()
  end

  def solve_input do
    Advent2022.Input.get(:day7)
    |> read_lines()

    # |> sum_file_sizes()
  end

  def sum_file_sizes(file_system) do
    file_system
    |> Map.values()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def read_lines(lines) do
    lines
    |> do_parsing(%{}, ["/"])
  end

  defp do_parsing([line | lines], files, cwd) do
    is_cd? = String.contains?(line, "cd")
    is_ls? = String.contains?(line, "ls")

    cond do
      is_cd? ->
        do_parsing(lines, files, get_new_cwd(line, cwd))

      is_ls? ->
        {dir_file_sizes, next_lines} = read_ls(lines)

        ## Change this so EVERY path is updated.
        files = Map.put(files, cwd, dir_file_sizes)

        do_parsing(next_lines, files, cwd)
    end
  end

  # defp update_dir_sizes(map, cwd) do
  #   path = Enum.join(cwd, "/")
  #   do_update(map, cwd)
  # end
  defp do_parsing(_, files, _), do: files

  defp read_ls(lines) do
    next_command =
      lines
      |> Enum.find_index(&String.contains?(&1, "$")) || Enum.count(lines)

    dir_file_sizes =
      lines
      |> Enum.take(next_command)
      |> Enum.reject(&String.contains?(&1, "dir"))
      |> Enum.map(fn str ->
        {num, _} = Integer.parse(str)
        num
      end)

    next_lines = Enum.drop(lines, next_command)

    {dir_file_sizes, next_lines}
  end

  def get_new_cwd(line, cwd) do
    [_dollar_sign, new_dir] = String.split(line, "cd", parts: 2)

    case {String.trim(new_dir), cwd} do
      {"..", _} ->
        Enum.drop(cwd, -1)

      {"/", _} ->
        ["/"]

      {dir, "/"} ->
        ["/", dir]

      {dir, _} ->
        :lists.append(cwd, [dir])
    end
  end
end
