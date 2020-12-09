defmodule Advent2020.Day9 do
  use Advent2020.Utils

  def main(input) do
    part1 = find_invalid(input)
    range = find_contiguous(input, to: part1)
    part2 = Enum.min(range) + Enum.max(range)
    answer Advent2020.Answer.new(part1, part2)
  end

  def find_invalid(list, preamble_length \\ 25) do
    Range.new(preamble_length, length(list))
    |> Enum.find_value(fn n -> if valid?(list, n, preamble_length) do false else Enum.at(list, n) end end)
  end

  def has_pair?(list, n), do: list |> Enum.any?(fn num -> Enum.member?(list, n - num) end)
  def valid?(list, ix, length \\ 25), do: has_pair?(Enum.slice(list, ix - length, ix), Enum.at(list, ix))

  def find_contiguous(list, to: to) do
    range =
      Range.new(0, length(list))
      |> Enum.find_value(fn i -> create_contiguous_range(list, i, to) end)

    case range do
      false -> raise "No contiguous region found!"
      _ -> Enum.slice(list, range)
    end
  end

  def create_contiguous_range(list, start, to) do
    ix = contiguous?(list, start, to)
    case ix do
      false -> false
      _ -> Range.new(start, ix)
    end
  end

  def contiguous?(list, start, to), do: contiguous?(list, start, 0, to)
  def contiguous?(list, ix, sum, to) do
    new_sum = sum + Enum.at(list, ix)
    cond do
      new_sum === to -> ix
      new_sum > to -> false
      true -> contiguous?(list, ix + 1, new_sum, to)
    end
  end
end
