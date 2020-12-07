defmodule Advent2020Day7Test do
  use ExUnit.Case
  alias Advent2020.Day7
  doctest Advent2020.Day7
  @moduletag :day7

  describe "Graph" do
    test "new creates empty array" do
      assert Day7.BagGraph.new === []
    end

    test "clean bags returns nil when no other bags" do
      assert Day7.BagGraph.clean_bag("no other bags.") === nil
    end

    test "clean bags returns array of bag colors and counts" do
      assert Day7.BagGraph.clean_bag(" 5 bright red bags.") === {5, "bright red"}
    end

    test "parse rule returns bag and sub-bags" do
      {bag, contains} = Day7.BagGraph.parse_rule("light red bags contain 1 bright white bag, 2 muted yellow bags.")
      assert bag == "light red"
      assert length(contains) === 2
      assert hd(contains) === {1, "bright white"}
      assert Enum.at(contains, 1) === {2, "muted yellow"}
    end
  end
end
