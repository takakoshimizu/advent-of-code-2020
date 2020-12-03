defmodule Mix.Tasks.Day3 do
  use Mix.Task

  @shortdoc "Runs the day 3 problem."
  def run(_) do
    Advent2020.Day3.main(input())
  end

  defp input, do: String.split(File.read!("./lib/advent2020/day3/input.txt"), "\n")
end
