defmodule Year2018Test.One do
  use ExUnit.Case

  test "solves part one" do
    IO.puts("\n--------------------")
    IO.puts("solution to day one part one:")

    File.read!('./inputs/1')
    |> Year2018.One.part_one
    |> IO.inspect
  end

  test "solves part two" do
    IO.puts("\n--------------------")
    IO.puts("solution to day one part two:")

    File.read!('./inputs/1')
    |> Year2018.One.part_two
    |> IO.inspect
  end
end
