defmodule Advent2020Day3Test do
  use ExUnit.Case
  doctest Advent2020.Day3
  @moduletag :day3

  @input \
    ~S[..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#]
    |> String.split("\n", trim: true )
    |> Enum.map(&String.trim/1)

  describe "next_spot" do
    test "returns new position by default movement strat" do
      {_tree, {x, y}} = Advent2020.Day3.next_spot(@input, {0, 0})
      assert x === 3
      assert y === 1
    end

    test "returns new position by custom movement strategy" do
      {_tree, {x, y}} = Advent2020.Day3.next_spot(@input, {0, 0}, {4, 4})
      assert x === 4
      assert y === 4
    end

    test "should wrap around x coords" do
      {_tree, {x, _y}} = Advent2020.Day3.next_spot(@input, {9, 0})
      assert x === 1
    end

    test "returns whether next spot is tree" do
      {tree, _pos} = Advent2020.Day3.next_spot(@input, {0, 0})
      assert not(tree)
      {tree2, _pos} = Advent2020.Day3.next_spot(@input, {3, 1})
      assert tree2
    end
  end

  describe "traverse_map" do
    test "returns state when y is at end of map" do
      trees = Advent2020.Day3.traverse_map(@input, nil, {5, {0, 11}})
      assert trees === 5
    end

    test "traverses until reaching end of map; returns number of trees encountered" do
      trees = Advent2020.Day3.traverse_map(@input)
      assert trees === 7
    end

    test "traverses with custom movement strategy" do
      trees = Advent2020.Day3.traverse_map(@input, {1, 1})
      assert trees === 2
    end

    test "confirm other given cases" do
      assert Advent2020.Day3.traverse_map(@input, {5, 1}) === 3
      assert Advent2020.Day3.traverse_map(@input, {7, 1}) === 4
      assert Advent2020.Day3.traverse_map(@input, {1, 2}) === 2
    end
  end
end
