defmodule Year2018Test.Seven do
  use ExUnit.Case

  test "from online example, part one" do
    instructions = [
      "Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin."
    ]

    assert Year2018.Seven.part_one(instructions) == "CABDFE"
  end

  test "from online example, part two" do
    instructions = [
      "Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin."
    ]

    assert Year2018.Seven.part_two(instructions, 0, 2) == 15
  end

  test "solves part one" do
    IO.puts("\n--------------------")
    IO.puts("solution to day seven part one:")

    File.read!('./inputs/7')
    |> String.split("\n", trim: true)
    |> Year2018.Seven.part_one()
    |> IO.inspect()
  end

  describe "steps" do
    def instructions() do
      [
        "Step C must be finished before step A can begin.",
        "Step C must be finished before step F can begin.",
        "Step A must be finished before step B can begin.",
        "Step A must be finished before step D can begin.",
        "Step B must be finished before step E can begin.",
        "Step D must be finished before step E can begin.",
        "Step F must be finished before step E can begin."
      ]
    end

    test "knows the next step available" do
      steps = Year2018.Seven.Steps.new(instructions(), 60)

      assert [{"C", 63}] == Year2018.Seven.Steps.available(steps)
    end

    test "updates a step" do
      steps = Year2018.Seven.Steps.new(instructions(), 60)
              |> Year2018.Seven.Steps.count_down(["C"])

      assert [{"C", 62}] == Year2018.Seven.Steps.available(steps)
    end

    test "deletes a step and knows the new ones available" do
      steps = Year2018.Seven.Steps.new(instructions(), 60)
              |> Year2018.Seven.Steps.delete(["C"])

      assert [{"A", 61}, {"F", 66}] == Year2018.Seven.Steps.available(steps)
    end

    test "supports the last step" do
      steps = Year2018.Seven.Steps.new([
        "Step A must be finished before step B can begin."
      ], 60)
      |> Year2018.Seven.Steps.delete(["A"])

      assert [{"B", 62}] == Year2018.Seven.Steps.available(steps)
    end
  end


  test "solves part two" do
    IO.puts("\n--------------------")
    IO.puts("solution to day seven part two:")

    File.read!('./inputs/7')
    |> String.split("\n", trim: true)
    |> Year2018.Seven.part_two(60, 5)
    |> IO.inspect()
  end

end
