defmodule Mix.Tasks.Day7 do
  use Mix.Task

  @shortdoc "Runs the day 6 problem."
  def run(_) do
    Advent2020.Day7.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day7/input.txt"), "\n", trim: true)
end
