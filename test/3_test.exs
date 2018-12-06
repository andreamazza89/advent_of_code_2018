defmodule Year2018Test.Three do
  use ExUnit.Case

  describe "part one" do
    test "example overlap" do
      total_overlaps =
        ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]
        |> Year2018.Three.part_one()

      assert total_overlaps == 4
    end

    test "calculates the cells covered by a claim (example one)" do
      cells_covered =
        "#1 @ 1,3: 4x4"
        |> Year2018.Three.Claim.create()
        |> Year2018.Three.Claim.cells_covered()

      assert Enum.sort(cells_covered) == Enum.sort([
               {1, 3}, {2, 3}, {3, 3}, {4, 3},
               {1, 4}, {2, 4}, {3, 4}, {4, 4},
               {1, 5}, {2, 5}, {3, 5}, {4, 5},
               {1, 6}, {2, 6}, {3, 6}, {4, 6}
             ])
    end

    test "calculates the cells covered by a claim (example two)" do
      cells_covered =
        "#666 @ 444,31: 1x2"
        |> Year2018.Three.Claim.create()
        |> Year2018.Three.Claim.cells_covered()

      assert Enum.sort(cells_covered) == Enum.sort([{444, 31}, {444, 32}])
    end

    test "solves part one" do
      IO.puts("\n--------------------")
      IO.puts("solution to day three part one:")

      File.read!('./inputs/3')
      |> String.split("\n", trim: true)
      |> Year2018.Three.part_one()
      |> IO.inspect()
    end
  end

  describe "part two" do
    test "no overlap example one" do
      non_overlapping_id =
        ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 55,22: 2x2"]
        |> Year2018.Three.part_two()

      assert non_overlapping_id == 3
    end

    test "no overlap example two" do
      non_overlapping_id =
        ["#1 @ 1,3: 2x2", "#2 @ 44,33: 4x4", "#3 @ 1,4: 2x2", "#4 @ 1,4: 2x3"]
        |> Year2018.Three.part_two()

      assert non_overlapping_id == 2
    end

    test "no overlap example three" do
      non_overlapping_id =
        ["#1 @ 111,30: 2x2", "#2 @ 2,3: 2x2", "#3 @ 1,4: 2x2", "#4 @ 1,4: 2x2"]
        |> Year2018.Three.part_two()

      assert non_overlapping_id == 1
    end

    test "solves part two" do
      IO.puts("\n--------------------")
      IO.puts("solution to day three part two:")

      File.read!('./inputs/3')
      |> String.split("\n", trim: true)
      |> Year2018.Three.part_two()
      |> IO.inspect()
    end
  end
end
