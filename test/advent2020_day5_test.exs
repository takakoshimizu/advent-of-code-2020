defmodule Advent2020Day5Test do
  use ExUnit.Case
  alias Advent2020.Day5
  doctest Advent2020.Day5
  @moduletag :day5

  test "seat_id multiplies to id" do
    result = Day5.seat_id(44, 5)
    assert result === 357
  end

  describe "Slice" do
    alias Advent2020.Day5.Slice

    test "can create" do
      %Slice{high: 5, low: 1}
    end

    test "creates default" do
      default = Slice.new()
      assert default.high === 127
      assert default.low === 0
    end

    test "steps through front" do
      result = Slice.new() |> Slice.next("F")
      assert result.low === 0
      assert result.high === 63
    end

    test "steps through back" do
      result = Slice.new(63) |> Slice.next("B")
      assert result.low === 32
      assert result.high === 63
    end

    test "steps through entire sample problem" do
      result =
        Slice.new()
        |> Slice.next("F")
        |> Slice.next("B")
        |> Slice.next("F")
        |> Slice.next("B")
        |> Slice.next("B")
        |> Slice.next("F")
        |> Slice.next("F")
      assert result.low === result.high
      assert result.low === 44
    end

    test "steps through right" do
      result = Slice.new(7) |> Slice.next("R")
      assert result.low === 4
      assert result.high === 7
    end

    test "steps through left" do
      result = Slice.new(7, 4) |> Slice.next("L")
      assert result.low === 4
      assert result.high === 5
    end

    test "steps through entire column sample problem" do
      result =
        Slice.new(7)
        |> Slice.next("R")
        |> Slice.next("L")
        |> Slice.next("R")
      assert result.low === result.high
      assert result.low === 5
    end
  end

  describe "Slice.decode" do
    alias Advent2020.Day5.Slice

    test "decodes full string" do
      assert Slice.decode("FBFBBFF") === 44
    end

    test "decodes full column string" do
      assert Slice.decode("RLR", 7) === 5
    end

    test "decodes all sample row strings" do
      assert Slice.decode("BFFFBBF") === 70
      assert Slice.decode("FFFBBBF") === 14
      assert Slice.decode("BBFFBBF") === 102
    end

    test "decodes all sample column strings" do
      assert Slice.decode("RRR", 7) === 7
      assert Slice.decode("RLL", 7) === 4
    end
  end
end
