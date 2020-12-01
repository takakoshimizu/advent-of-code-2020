defmodule Advent2020.Day1 do
  @sum_target 2020

  def main do
    nums = Enum.map(String.split(File.read!("input.txt"), "\n"), &String.to_integer/1)
    IO.puts("Passcode is #{nums |> sum_set |> product}.")
    IO.puts("Second passcode is #{nums |> sum_set(3) |> product}.")
  end

  defp sums_to?(n, list, num_matches) do
    case num_matches do
      0 -> false
      1 -> n === @sum_target
      _ -> Enum.any?(list, &(sums_to?(&1 + n, list, num_matches - 1)))
    end
  end

  defp sum_set(numbers, num_matches \\ 2), do: Enum.filter(numbers, &(sums_to?(&1, numbers, num_matches)))
  defp product(ns), do: Enum.reduce(ns, &*/2)
end

Advent2020.Day1.main()
