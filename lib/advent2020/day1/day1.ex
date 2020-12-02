defmodule Advent2020.Day1 do
  use Advent2020.Utils
  @sum_target 2020

  def main do
    answers = Enum.map(input(), &String.to_integer/1) |> sum_sets |> Advent2020.Answer.new
    answer answers
  end

  defp sum_sets(numbers) do
    { numbers |> sum_set |> product,
      numbers |> sum_set(3) |> product }
  end

  defp sum_set(numbers, num_matches \\ 2) do
    Enum.filter(numbers, &(sums_to?(&1, numbers, num_matches)))
  end

  defp sums_to?(n, _list, 1), do: n === @sum_target
  defp sums_to?(n, list, num_matches) when num_matches > 1, do: Enum.any?(list, &(sums_to?(&1 + n, list, num_matches - 1)))
  defp product(ns), do: Enum.reduce(ns, &*/2)
end
