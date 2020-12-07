defmodule Advent2020.Day7 do
  use Advent2020.Utils
  alias Advent2020.Day7.BagGraph

  def main(input) do
    bags = input |> Enum.reduce(BagGraph.new(), &BagGraph.add/2)

    first = bags |> BagGraph.containing?("shiny gold") |> length
    second = bags |> BagGraph.within("shiny gold")
    answer Advent2020.Answer.new(first, second)
  end

  defmodule BagGraph do
    def new do
      []
    end

    def add(rule, graph) do
      [parse_rule(rule) | graph]
    end

    def containing?(graph, search) do
      graph
      |> Enum.filter(fn {color, _bags} -> color !== search end)
      |> Enum.filter(fn {color, _bags} -> containing?(graph, color, search) end)
    end

    def containing?(_graph, bag, search) when bag === search, do: true
    def containing?(graph, bag, search) do
      graph
      |> Enum.find(fn {color, _bags} -> color === bag end)
      |> elem(1)
      |> Enum.any?(fn {_count, color} -> containing?(graph, color, search) end)
    end

    def within(graph, bag) do
      graph
      |> Enum.find(fn {color, _bags} -> color === bag end)
      |> elem(1)
      |> Enum.map(fn {count, color} -> count + count * within(graph, color) end)
      |> Enum.sum()
    end

    def parse_rule(rule) do
      [color, contains] = String.split(rule, " bags contain ", trim: true)
      bags =
        contains
        |> String.split(", ", trim: true)
        |> Enum.map(&clean_bag/1)
        |> Enum.filter(fn b -> b end)
      {color, bags}
    end

    def clean_bag(bag) do
      if bag === "no other bags." do
        nil
      else
        {count, color} = bag |> String.trim() |> Integer.parse()
        {count, color |> String.replace(~r/bags?|\.|\,/, "") |> String.trim()}
      end
    end
  end
end
