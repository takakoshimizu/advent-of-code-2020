defmodule Mix.Tasks.Day5 do
  use Mix.Task

  @shortdoc "Runs the day 5 problem."
  def run(_) do
    Advent2020.Day5.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day5/input.txt"), "\n", trim: true)
end
