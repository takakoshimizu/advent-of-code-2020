defmodule Advent2020Day4Test do
  use ExUnit.Case
  doctest Advent2020.Day4
  @moduletag :day4

  @input [
    ~S[ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
       byr:1937 iyr:2017 cid:147 hgt:183cm],
    ~S[iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
       hcl:#cfa07d byr:1929],
    ~S[hcl:#ae17e1 iyr:2013
       eyr:2024
       ecl:brn pid:760753108 byr:1931
       hgt:179cm],
    ~S[hcl:#cfa07d eyr:2025 pid:166559648
       iyr:2011 ecl:brn hgt:59in]
  ]

  describe "Passport" do
    test "can create" do
      %Advent2020.Day4.Passport{byr: '2020'}
    end

    test "create from record works" do
      record = Advent2020.Day4.Passport.new(@input |> hd)
      assert record.ecl === "gry"
      assert record.hgt === "183cm"
      assert record.byr === 1937
    end

    test "validates required fields are populated" do
      valid? = Advent2020.Day4.Passport.valid?(
        %Advent2020.Day4.Passport{byr: '2020'}
      )
      assert not valid?

      valid? = Advent2020.Day4.Passport.valid?(
        %Advent2020.Day4.Passport{byr: '2020', iyr: '2020', eyr: '2021', hgt: '123cm', hcl: '#000', ecl: '#000', pid: '2111' }
      )
      assert valid?
    end

    test "validates strict" do
      valid = [
        ~S[pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
           hcl:#623a2f],
        ~S[eyr:2029 ecl:blu cid:129 byr:1989
           iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm],
        ~S[hcl:#888785
           hgt:164cm byr:2001 iyr:2015 cid:88
           pid:545766238 ecl:hzl
           eyr:2022],
        ~S[iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719]
      ]

      valid? = valid
        |> Enum.map(&Advent2020.Day4.Passport.new/1)
        |> Enum.all?(fn p -> Advent2020.Day4.Passport.valid?(p, strict: true) end)
      assert valid?
    end

    test "invalidates strict" do
      valid = [
        ~S[eyr:1972 cid:100
           hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926],
        ~S[iyr:2019
           hcl:#602927 eyr:1967 hgt:170cm
           ecl:grn pid:012533040 byr:1946],
        ~S[hcl:dab227 iyr:2012
           ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277],
        ~S[hgt:59cm ecl:zzz
           eyr:2038 hcl:74454a iyr:2023
           pid:3556412378 byr:2007]
      ]

      valid? = valid
        |> Enum.map(&Advent2020.Day4.Passport.new/1)
        |> Enum.all?(fn p -> Advent2020.Day4.Passport.valid?(p, strict: true) end)
      assert not valid?
    end

    test "byr validation" do
      assert Advent2020.Day4.Passport.valid_birth_year?(2002)
      assert not Advent2020.Day4.Passport.valid_birth_year?(2003)
    end

    test "iyr validation" do
      assert Advent2020.Day4.Passport.valid_issue?(2010)
      assert not Advent2020.Day4.Passport.valid_issue?(2009)
    end

    test "eyr validation" do
      assert Advent2020.Day4.Passport.valid_expiration?(2020)
      assert not Advent2020.Day4.Passport.valid_expiration?(2031)
    end

    test "hgt validation" do
      assert Advent2020.Day4.Passport.valid_height?("60in")
      assert Advent2020.Day4.Passport.valid_height?("190cm")
      assert not Advent2020.Day4.Passport.valid_height?("190in")
      assert not Advent2020.Day4.Passport.valid_height?("190")
    end

    test "hcl validation" do
      assert Advent2020.Day4.Passport.valid_hair?("#123abc")
      assert not Advent2020.Day4.Passport.valid_hair?("#123abz")
      assert not Advent2020.Day4.Passport.valid_hair?("123abc")
    end

    test "ecl validation" do
      assert Advent2020.Day4.Passport.valid_eye?("brn")
      assert not Advent2020.Day4.Passport.valid_eye?("wat")
    end

    test "pid validation" do
      assert Advent2020.Day4.Passport.valid_pid?("000000001")
      assert not Advent2020.Day4.Passport.valid_pid?("0123456789")
    end
  end
end
