# advent-of-code-2020
Time to learn Elixir until I get bored or overwhelmed!

## Description
This repository houses my [Advent of Code 2020](https://adventofcode.com/2020) attempts.
Each day a challenge is posted to solve in a language of your choosing, as a sort of
super-kata thing to warm up for the day. They...frequently get out of hand quickly.

## Prerequisites
You must [install Elixir](https://elixir-lang.org/install.html) to your machine. 
At time of writing, I am using Elixir 1.10.4 on Erlang/OTP 23.

## Running a day's code.
Currently, each day is written as a simple `.exs` script file. This means, to run the code,
all one needs to do is run `elixir [filename]` and get the output to their terminal. Each day
will have any needed input alongside it.

IE: 
```bash
➜  day-1 git:(trunk) ✗ elixir day1.exs
Passcode is 259716.
Second passcode is 120637440.
```

Later days may very well begin to use `mix` dependencies, and the README will be updated
accordingly if that occurs.
