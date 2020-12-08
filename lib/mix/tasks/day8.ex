defmodule Mix.Tasks.Day8 do
  use Mix.Task

  @shortdoc "Runs the day 8 problem."
  def run(_) do
    Advent2020.Day8.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day8/input.txt"), "\n", trim: true)
end
