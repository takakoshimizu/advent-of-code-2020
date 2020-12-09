defmodule Mix.Tasks.Day9 do
  use Mix.Task

  @shortdoc "Runs the day 9 problem."
  def run(_) do
    Advent2020.Day9.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day9/input.txt"), "\n", trim: true) |> Enum.map(&String.to_integer/1)
end
