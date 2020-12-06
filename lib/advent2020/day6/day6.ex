defmodule Advent2020.Day6 do
  use Advent2020.Utils
  alias Advent2020.Day6.Group

  def main(input) do
    groups = input |> Enum.map(&Group.new/1)

    first = groups |> tally_by(&MapSet.union/2)
    second = groups |> tally_by(&MapSet.intersection/2)
    answer Advent2020.Answer.new(first, second)
  end

  @spec tally_by([[MapSet]], function()) :: number
  def tally_by(groups, tally_fn) do
    groups |> Enum.map(&(Enum.reduce(&1, tally_fn))) |> Enum.map(&MapSet.size/1) |> Enum.sum()
  end

  defmodule Group do
    @spec new(binary) :: [MapSet]
    def new(group) do
      group |> String.split() |> Enum.map(&Group.group_line/1)
    end

    @spec group_line(binary) :: MapSet
    def group_line(line), do: line |> String.split("", trim: true) |> Enum.into(MapSet.new())
  end
end
