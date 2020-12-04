defmodule Advent2020.Utils do
  defmacro __using__(_params) do
    quote do
      def input, do: String.split(File.read!("./lib/advent2020/#{module_folder()}/input.txt"), "\n")
      defp module_folder, do: __MODULE__ |> to_string |> String.split(".") |> List.last |> String.downcase

      def answer(%Advent2020.Answer{part1: part1, part2: part2}) when not(is_binary(part1)) and not(is_binary(part2)) do
        answer(%Advent2020.Answer{ part1: to_string(part1), part2: to_string(part2) })
      end

      def answer(%Advent2020.Answer{part1: part1, part2: part2}) when is_binary(part1) and is_binary(part2) do
        IO.puts("The 1st answer is #{part1}.")
        if String.length(part2) > 0 do
          IO.puts("The 2nd answer is #{part2}.")
        end
      end

      defoverridable [input: 0]
    end
  end

  # https://medium.com/@kay.sackey/create-a-struct-from-a-map-within-elixir-78bf592b5d3b
  def struct_from_map(a_map, as: a_struct) do
    # Find the keys within the map
    keys = Map.keys(a_struct)
      |> Enum.filter(fn x -> x != :__struct__ end)

    processed_map = for key <- keys, into: %{} do
      value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
      {key, value}
    end

    a_struct = Map.merge(a_struct, processed_map)
    a_struct
  end
end

defmodule Advent2020.Answer do
  defstruct part1: '', part2: ''

  def new(part1, part2), do: %Advent2020.Answer{ part1: part1, part2: part2 }
  def new([part1, part2]), do: new(part1, part2)
  def new({part1, part2}), do: new(part1, part2)
end
