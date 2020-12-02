defmodule Advent2020.Day2 do
  use Advent2020.Utils

  def main do
    passwords = Enum.map(input(), &Advent2020.Day2.Password.new/1)
    valid_passwords = passwords |> Enum.map(&Advent2020.Day2.Password.valid?/1) |> Enum.filter(fn {part1, part2} -> part1 or part2 end)

    part1 = valid_passwords |> Enum.filter(fn {part1, _part2} -> part1 end) |> length
    part2 = valid_passwords |> Enum.filter(fn {_part1, part2} -> part2 end) |> length()
    answer Advent2020.Answer.new(part1, part2)
  end

  defmodule PasswordPolicy do
    defstruct letter: 'a', start: 1, stop: 2

    def new(policy_def) do
      [range, letter] = String.split(policy_def, " ", parts: 2)
      [start, stop] = String.split(range, "-", parts: 2) |> Enum.map(&String.to_integer/1)
      %PasswordPolicy{ letter: letter, start: start, stop: stop }
    end

    def valid?(password, %PasswordPolicy{ letter: letter, start: start, stop: stop }) do
      range = Range.new(start, stop)
      letters = String.split(password, "", trim: true)
      { length(Enum.filter(letters, &(&1 == letter))) in range,
        xor(valid_letter?(password, letter, start), valid_letter?(password, letter, stop))}
    end

    defp valid_letter?(password, letter, ix), do: String.at(password, ix - 1) === letter
    defp bool_to_int(b) when is_boolean(b), do: b && 1 || 0

    # for some reason ^^^ wouldn't work correctly so I did a redneck xor
    defp xor(b1, b2), do: bool_to_int(b1) + bool_to_int(b2) == 1
  end

  defmodule Password do
    defstruct password: 'a', policy: %PasswordPolicy{}

    def new(password_line) do
      [policy, password] = String.split(password_line, ":", parts: 2)
      %Password{ password: String.trim(password), policy: PasswordPolicy.new(policy) }
    end

    def valid?(%Password{ password: password, policy: policy }) do
      PasswordPolicy.valid?(password, policy)
    end
  end
end
