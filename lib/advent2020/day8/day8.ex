defmodule Advent2020.Day8 do
  use Advent2020.Utils

  def main(input) do
    instructions = input |> Enum.map(&parse/1)

    {part1, _} = instructions |> execute()
    part2 = instructions |> Enum.zip(Range.new(0, 1000)) |> Enum.find_value(fn i -> test_swap(instructions, i) end)

    answer Advent2020.Answer.new(part1, part2)
  end

  def execute(instructions), do: execute({0, 0}, MapSet.new(), instructions)
  def execute({cur_state, line} = state, executed, instructions) do
    cond do
      MapSet.member?(executed, line) -> {cur_state, :dup}
      line > length(instructions) - 1 -> {cur_state, :end}
      true -> state
              |> next_state(Enum.at(instructions, line))
              |> execute(MapSet.put(executed, line), instructions)
    end
  end

  def test_swap(instructions, {{op, _c}, line}) do
    case op do
      :acc -> false
      _ ->
        {val, reason} =
          instructions
          |> List.update_at(line, fn {op, c} -> {if op === :jmp do :nop else :jmp end, c} end)
          |> execute()

        case reason do
          :end -> val
          _ -> false
        end
    end
  end

  def next_state({state, line}, {instruction, val}) do
    case instruction do
      :nop -> {state, line + 1}
      :jmp -> {state, line + val}
      :acc -> {state + val, line + 1}
    end
  end

  def parse(instruction) do
    instruction
    |> String.split(" ", trim: true)
    |> parse_split()
  end

  defp parse_split([inst, num]), do: {String.to_atom(inst), String.to_integer(num)}
end
