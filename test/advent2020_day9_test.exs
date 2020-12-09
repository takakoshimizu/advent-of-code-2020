defmodule Advent2020Day9Test do
  use ExUnit.Case
  alias Advent2020.Day9
  doctest Advent2020.Day9
  @moduletag :day9

  describe "has_pair?" do
    test "should return true if list slice has a pair" do
      assert Day9.has_pair?([35, 20, 10], 55)
    end

    test "should return false if list slice has no pair" do
      assert not Day9.has_pair?([35, 20, 10], 56)
    end
  end

  describe "valid?" do
    test "should validate previous X number of elements has pair" do
      assert Day9.valid?([35, 20, 10, 4, 1, 5], 5, 5)
      assert not Day9.valid?([35, 20, 10, 5, 1, 5], 5, 5)
    end
  end

  describe "find_invalid" do
    test "validates to first invalid number via sample" do
      input = ~w[35 20 15 25 47 40 62 55 65 95 102 117 150 182 127 219 299 277 309 576] |> Enum.map(&String.to_integer/1)

      assert Day9.find_invalid(input, 5) === 127
    end
  end

  describe "contiguous?" do
    @input ~w[35 20 15 25 47 40 62 55 65 95 102 117 150 182 127 219 299 277 309 576] |> Enum.map(&String.to_integer/1)

    test "returns the index where a contiguous sum was found" do
      assert Day9.contiguous?(@input, 2, 0, 127) === 5
    end

    test "returns false if no sum found" do
      assert not Day9.contiguous?(@input, 1, 0, 127)
    end

    test "shorthand returns range in tuple" do
      assert Day9.contiguous?(@input, start: 2, to: 127) === {2, 5}
    end
  end
end
