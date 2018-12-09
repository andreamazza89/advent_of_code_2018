defmodule Year2018Test.Five do
  use ExUnit.Case

  alias Year2018.Five

  describe "processes reactions" do
    test "no reactions" do
      polymer = "abCCEffG"

      assert polymer == Five.process_reactions(polymer)
    end

    test "one reaction" do
      polymer = "abCcEfG"

      assert "abEfG" == Five.process_reactions(polymer)
    end

    test "another reaction" do
      polymer = "abCcEfFGG"

      assert "abEGG" == Five.process_reactions(polymer)
    end

    test "reactions after first run" do
      polymer = "abCcBEfFGG"

      assert "aEGG" == Five.process_reactions(polymer)
    end

    test "reactions after first run and at the edges of the polymer" do
      polymer = "aDdAbCcBEfFGGfFg"

      assert "EG" == Five.process_reactions(polymer)
    end

    test "yet another example" do
      polymer = "dabAcCaCBAcCcaDA"

      assert "dabCBAcaDA" == Five.process_reactions(polymer)
    end

    test "all the examples" do
      polymer = "vVuyYJjUzzZPxXqQpZmgGMvNmMyYTtnVk"

      assert "k" == Five.process_reactions(polymer)
    end
  end

  describe "part one" do
    test "solves part one" do
      IO.puts("\n--------------------")
      IO.puts("solution to day five part one:")

      File.read!('./inputs/5')
      |> Year2018.Five.part_one()
      |> String.length()
      |> IO.inspect()
    end

    test "solves part two" do
      IO.puts("\n--------------------")
      IO.puts("solution to day five part two:")

      File.read!('./inputs/5')
      |> Year2018.Five.part_two()
      |> String.length()
      |> IO.inspect()
    end
  end
end
