defmodule Advent2020.Day4 do
  use Advent2020.Utils

  def main(input) do
    passports = input |> String.split("\n\n", trim: true) |> Enum.map(&Advent2020.Day4.Passport.new/1)
    part1 = passports |> Enum.count(&Advent2020.Day4.Passport.valid?/1)
    part2 = passports |> Enum.count(fn p -> Advent2020.Day4.Passport.valid?(p, strict: true) end)
    answer Advent2020.Answer.new(part1, part2)
  end

  defmodule Passport do
    @integer_keys [:byr, :iyr, :eyr]
    @required @integer_keys ++ [:hgt, :hcl, :ecl, :pid]
    defstruct @required ++ [:cid]

    def new(passport_def) do
      passport_def
        |> String.split(~r/[\s\n]/, trim: true)
        |> Enum.map(fn s -> String.split(s, ":", trim: true) end)
        |> Map.new(fn [k, v] -> {String.to_existing_atom(k), to_val(k, v)} end)
        |> Advent2020.Utils.struct_from_map(as: %Passport{})
    end

    def to_val(key, value) do
      if String.to_existing_atom(key) in @integer_keys do
        String.to_integer(value)
      else
        String.trim(value)
      end
    end

    def valid?(passport), do: Enum.all?(@required, fn key -> Map.get(passport, key) != nil end)
    def valid?(passport, strict: true) do
      valid?(passport) and
        valid_birth_year?(passport.byr) and
        valid_issue?(passport.iyr) and
        valid_expiration?(passport.eyr) and
        valid_height?(passport.hgt) and
        valid_hair?(passport.hcl) and
        valid_eye?(passport.ecl) and
        valid_pid?(passport.pid)
    end

    def valid_birth_year?(birth_year), do: birth_year >= 1920 and birth_year <= 2002
    def valid_issue?(issue_year), do: issue_year >= 2010 and issue_year <= 2020
    def valid_expiration?(expiration), do: expiration >= 2020 and expiration <= 2030
    def valid_hair?(hair), do: String.match?(hair, ~r/^\#[0-9a-f]{6}$/)
    def valid_eye?(eye), do: eye in ~w[amb blu brn gry grn hzl oth]
    def valid_pid?(pid), do: String.match?(pid, ~r/^[0-9]{9}$/)

    def valid_height?(height) do
      {height, unit} = Integer.parse(height)
      case unit do
        "in" -> height >= 59 and height <= 76
        "cm" -> height >= 150 and height <= 193
        _ -> false
      end
    end
  end
end
