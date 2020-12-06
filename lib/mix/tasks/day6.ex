defmodule Mix.Tasks.Day6 do
  use Mix.Task

  @shortdoc "Runs the day 6 problem."
  def run(_) do
    Advent2020.Day6.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day6/input.txt"), "\n\n", trim: true)
end
