defmodule Mix.Tasks.Day10 do
  use Mix.Task

  @shortdoc "Runs the day 10 problem."
  def run(_) do
    Advent2020.Day10.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day10/input.txt"), "\n", trim: true) |> Enum.map(&String.to_integer/1)
end
