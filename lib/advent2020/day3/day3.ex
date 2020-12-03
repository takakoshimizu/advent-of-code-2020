defmodule Advent2020.Day3 do
  use Advent2020.Utils

  def main(input) do
    results = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
      |> Enum.map(fn strat -> traverse_map(input, strat) end)
    part1 = Enum.at(results, 1)
    part2 = Enum.reduce(results, &*/2)
    answer Advent2020.Answer.new(part1, part2)
  end

  def next_spot(map, {x, y}, {move_x, move_y} \\ {3, 1}) do
    next_y = y + move_y
    row = Enum.at(map, next_y)

    next_x = rem(x + move_x, String.length(row))

    next_spot_tree = String.at(row, next_x) === "#"
    {next_spot_tree, {next_x, next_y}}
  end

  def bool_to_int(b) when is_boolean(b), do: b && 1 || 0

  @spec traverse_map([charlist], {number, number}, {number, {number, number}}) :: number
  def traverse_map(map, movement_strat \\ {3, 1}, state \\ {0, {0, 0}})
  def traverse_map(map, _movement_strat, {trees, {_x, y}}) when y + 1 >= length(map), do: trees
  def traverse_map(map, movement_strat, {trees, {x, y}}) when y + 1 < length(map) do
    {tree?, next_pos} = next_spot(map, {x, y}, movement_strat)
    traverse_map(map, movement_strat, {trees + bool_to_int(tree?), next_pos})
  end
end
