defmodule Year2018Test.Two do
  use ExUnit.Case

  describe "part one" do
    test "example checksum" do
      checksum =
        ~w{abcdef bababc abbcde abcccd aabcdd abcdee ababab}
        |> Year2018.Two.part_one()

      assert checksum == 12
    end

    test "solves part one" do
      IO.puts("\n--------------------")
      IO.puts("solution to day two part one:")

      File.read!('./inputs/2')
      |> String.split()
      |> Year2018.Two.part_one()
      |> IO.inspect()
    end
  end

  describe "part two" do
    test "example character difference" do
      result =
        ~w{abcde fghij klmno pqrst fguij axcye wvxyz}
        |> Year2018.Two.part_two()

      assert result == "fgij"
    end

    test "solves part two" do
      IO.puts("\n--------------------")
      IO.puts("solution to day two part two:")

      File.read!('./inputs/2')
      |> String.split()
      |> Year2018.Two.part_two()
      |> IO.inspect()
    end
  end
end
