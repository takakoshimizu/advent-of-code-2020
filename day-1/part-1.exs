defmodule Advent2020.Day1 do
  def main do
    {:ok, file} = File.read("input.txt")
    numbers = to_numbers(String.split(file, "\n"))

    passcode = product(sum_set(numbers))
    passcode2 = product(sum_set(numbers, 3))

    IO.puts("Passcode is #{passcode}.")
    IO.puts("Second passcode is #{passcode2}.")
  end

  defp to_numbers(numbers) do
    numbers
      |> Enum.map(fn str -> Integer.parse(str) end)
      |> Enum.map(fn {num, _rem} -> num end)
  end

  defp sum_set(numbers, num_matches \\ 2, sum_to \\ 2020) do
    numbers
     |> Enum.filter(fn n -> sums_to?(n, numbers, sum_to, num_matches) end)
  end

  def sums_to?(n, list, sums_to, num_matches) do
    case num_matches do
      0 -> false
      1 -> n === sums_to
      2 -> Enum.any?(list, fn num -> num + n === sums_to end)
      _ -> Enum.any?(list, fn num -> sums_to?(num + n, list, sums_to, num_matches - 1) end)
    end
  end

  defp product(list) do
    Enum.reduce(list, fn n, acc -> n * acc end)
  end
end

Advent2020.Day1.main()
