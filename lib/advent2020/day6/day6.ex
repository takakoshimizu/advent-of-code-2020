defmodule Advent2020.Day6 do
  use Advent2020.Utils

  def main(input) do
    groups = input |> Enum.map(&create_group/1)

    first = tally_by(groups, &MapSet.union/2)
    second = tally_by(groups, &MapSet.intersection/2)
    answer Advent2020.Answer.new(first, second)
  end

  def create_group(group) do
    group
    |> String.split()
    |> Enum.map(fn g -> g |> String.split("", trim: true) |> Enum.into(MapSet.new()) end)
  end

  def tally_by(groups, tally_fn) do
    groups |> Enum.map(fn g -> Enum.reduce(g, tally_fn) end) |> Enum.map(&MapSet.size/1) |> Enum.sum()
  end
end
