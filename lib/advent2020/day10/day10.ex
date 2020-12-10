defmodule Advent2020.Day10 do
  use Advent2020.Utils

  def main(input) do
    adapters = MapSet.new(input) |> MapSet.put(Enum.max(input) + 3) |> MapSet.put(0)
    {ones, threes} = Enum.reduce(adapters, {0, 0}, fn a, acc -> count(a, acc, adapters) end)
    part1 = ones * threes

    answer Advent2020.Answer.new(part1, 0)
  end

  def count(adapter, {ones, threes}, adapters) do
    cond do
      adapter + 1 in adapters -> {ones + 1, threes}
      adapter + 3 in adapters -> {ones, threes + 1}
      true -> {ones, threes}
    end
  end
end
