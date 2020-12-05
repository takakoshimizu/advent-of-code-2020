defmodule Advent2020.Day5 do
  use Advent2020.Utils
  alias Advent2020.Day5.Slice

  def main(input) do
    seats = input |> Enum.map(&seat_id/1)
    highest = Enum.max(seats)
    lowest = Enum.min(seats)

    missing =
      Range.new(lowest, highest)
      |> Enum.find(fn n -> n not in seats end)

    answer Advent2020.Answer.new(highest, missing)
  end

  def seat_id(pass_string) do
    {row, col} = String.split_at(pass_string, 7)
    seat_id(Slice.decode(row), Slice.decode(col, 7))
  end

  def seat_id(row, column), do: 8 * row + column

  defmodule Slice do
    defstruct [:high, :low]
    def new(high \\ 127, low \\ 0), do: %Slice{ low: low, high: high }

    def next(%Slice{ high: high, low: low }, step) do
      cond do
        step === "F" or step === "L" -> %Slice{ low: low, high: low + floor((high - low) / 2) }
        step === "B" or step === "R" -> %Slice{ high: high, low: low + ceil((high - low) / 2) }
      end
    end

    def decode(instructions, high \\ 127) do
      instructions
      |> String.split("", trim: true)
      |> Enum.reduce(Slice.new(high), fn letter, acc -> Slice.next(acc, letter) end)
      |> Map.get(:low)
    end
  end
end
