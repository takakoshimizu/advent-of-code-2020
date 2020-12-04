defmodule Mix.Tasks.Day4 do
  use Mix.Task

  @shortdoc "Runs the day 4 problem."
  def run(_) do
    Advent2020.Day4.main(input())
  end

  defp input, do: File.read!("./lib/advent2020/day4/input.txt")
end
