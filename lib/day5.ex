defmodule Advent2022.Day5 do
  def solve_test_input_part1 do
    {stacks, moves} = Advent2022.Input.get(:day5, :test)
    {:ok, pid} = GenServer.start_link(Advent2022.Crane, stacks)
  end
end

defmodule Advent2022.Crane do
  use GenServer

  def init(stacks) do
    {:ok, stacks}
  end

  def handle_cast({:move, {amount, from, to}}, state) do
    list_from = state[from]
    list_to = state[to]
    {:reply, state}
  end
end
