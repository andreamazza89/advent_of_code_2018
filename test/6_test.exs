defmodule Year2018Test.Six do
  use ExUnit.Case

  test "from online example part one" do
    coordinates = MapSet.new([{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}])

    assert Year2018.Six.part_one(coordinates) == 17
  end

  test "generates the enclosing area for the given coordinates (easy)" do
    coordinates = MapSet.new([{1, 1}, {2, 1}, {1, 2}, {2, 2}])

    enclosing_area = Year2018.Six.enclosing_area(coordinates)

    assert Enum.sort(enclosing_area) == Enum.sort(coordinates)
  end

  test "generates the enclosing area for the given coordinates (hard)" do
    coordinates = MapSet.new([{2, 2}, {1, 3}, {3, 4}, {4, 4}, {2, 5}])

    enclosing_area = Year2018.Six.enclosing_area(coordinates)

    expected_enclosing_area =
      MapSet.new([
        {1, 2}, {2, 2}, {3, 2}, {4, 2},
        {1, 3}, {2, 3}, {3, 3}, {4, 3},
        {1, 4}, {2, 4}, {3, 4}, {4, 4},
        {1, 5}, {2, 5}, {3, 5}, {4, 5}
      ])

    assert Enum.sort(enclosing_area) == Enum.sort(expected_enclosing_area)
  end

  test "solves part one" do
    IO.puts("\n--------------------")
    IO.puts("solution to day six part one:")

    File.read!('./inputs/6')
    |> prepare_input()
    |> Year2018.Six.part_one()
    |> IO.inspect()
  end

  test "from online example part two" do
    coordinates = MapSet.new([{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}])

    assert Year2018.Six.part_two(coordinates, 32) == 16
  end

  test "solves part two" do
    IO.puts("\n--------------------")
    IO.puts("solution to day six part two:")

    File.read!('./inputs/6')
    |> prepare_input()
    |> Year2018.Six.part_two(10000)
    |> IO.inspect()
  end

  def prepare_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn coordinates ->
      coord_info = Regex.named_captures(~r/(?<x>\d+), (?<y>\d+)/, coordinates)

      x = String.to_integer(coord_info["x"])
      y = String.to_integer(coord_info["y"])
      {x, y}
    end)
  end
end
