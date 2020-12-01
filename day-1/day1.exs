defmodule Advent2020.Day1 do
  @sum_target 2020

  def main do
    {:ok, file} = File.read("input.txt")
    numbers = to_numbers(String.split(file, "\n"))

    passcode = Enum.reduce(sum_set(numbers), &*/2)
    passcode2 = Enum.reduce(sum_set(numbers, 3), &*/2)

    IO.puts("Passcode is #{passcode}.")
    IO.puts("Second passcode is #{passcode2}.")
  end

  defp to_numbers(numbers) do
    numbers
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {num, _rem} -> num end)
  end

  defp sum_set(numbers, num_matches \\ 2) do
    Enum.filter(numbers, fn n -> sums_to?(n, numbers, num_matches) end)
  end

  def sums_to?(n, list, num_matches) do
    case num_matches do
      0 -> false
      1 -> n === @sum_target
      _ -> Enum.any?(list, fn num -> sums_to?(num + n, list, num_matches - 1) end)
    end
  end
end

Advent2020.Day1.main()
