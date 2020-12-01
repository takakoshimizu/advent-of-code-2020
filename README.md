# advent-of-code-2020
Time to learn Elixir until I get bored or overwhelmed!

## Description
This repository houses my [Advent of Code 2020](https://adventofcode.com/2020) attempts.
Each day a challenge is posted to solve in a language of your choosing, as a sort of
super-kata thing to warm up for the day. They...frequently get out of hand quickly.

## Prerequisites
You must [install Elixir](https://elixir-lang.org/install.html) to your machine. 
At time of writing, I am using Elixir 1.10.4 on Erlang/OTP 23.

Run `mix deps.get` to install any dependencies for later days.

## Running a day's code.
Each day is written as a separate context folder and a corresponding `mix` task. To execute a day's puzzle,
simply call the proper `mix` task.

IE: 
```bash
➜ advent-of-code-2020 git:(trunk) ✗ mix day1
Passcode is 259716.
Second passcode is 120637440.
```
