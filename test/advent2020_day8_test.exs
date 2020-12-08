defmodule Advent2020Day8Test do
  use ExUnit.Case
  alias Advent2020.Day8
  doctest Advent2020.Day8
  @moduletag :day8

  describe "parse" do
    alias Advent2020.Day8

    test "should parse the line" do
      assert Day8.parse("nop +0") === {:nop, 0}
      assert Day8.parse("acc -15") === {:acc, -15}
      assert Day8.parse("jmp -1") === {:jmp, -1}
    end
  end

  describe "next_state" do
    alias Advent2020.Day8

    test "returns next state" do
      assert Day8.next_state({0, 0}, {:nop, 0}) === {0, 1}
      assert Day8.next_state({0, 1}, {:acc, -15}) === {-15, 2}
      assert Day8.next_state({-15, 2}, {:jmp, -1}) === {-15, 1}
    end
  end

  describe "execute" do
    alias Advent2020.Day8

    test "returns state if line has been executed" do
      assert Day8.execute({-15, 0}, MapSet.new([0]), [{:jmp, -1}]) === {-15, :dup}
    end

    test "returns state if outside of instruction set" do
      assert Day8.execute({-15, 1}, MapSet.new([0]), [{:jmp, -1}]) === {-15, :end}
    end

    test "dives until line has been executed" do
      assert Day8.execute({0, 0}, MapSet.new([]), [{:acc, -15}, {:acc, 1}, {:jmp, -1}]) === {-14, :dup}
    end

    test "execute/1 kicks off list execution from default state" do
      assert Day8.execute([{:acc, -15}, {:acc, 1}, {:jmp, -1}]) === {-14, :dup}
    end
  end

  describe "provided examples" do
    alias Advent2020.Day8

    test "executes sample as expected" do
      input = [
        "nop +0",
        "acc +1",
        "jmp +4",
        "acc +3",
        "jmp -3",
        "acc -99",
        "acc +1",
        "jmp -4",
        "acc +6"
      ]

      assert Day8.execute(input |> Enum.map(&Day8.parse/1)) === {5, :dup}
    end

    test "executes part2 sample as expected" do
      input = [
        "nop +0",
        "acc +1",
        "jmp +4",
        "acc +3",
        "jmp -3",
        "acc -99",
        "acc +1",
        "nop -4",
        "acc +6"
      ]

      assert Day8.execute(input |> Enum.map(&Day8.parse/1)) === {8, :end}
    end
  end
end
