defmodule Year2018.Six do
  def part_one(input_coordinates) do
    enclosing_area = enclosing_area(input_coordinates)

    assignments =
      Enum.reduce(enclosing_area, %{}, fn spot, assignments ->
        distances = distances_from_a_to_many_coordinates(spot, input_coordinates)
        {from, smallest_distance} = Enum.min_by(distances, fn {_from, distance} -> distance end)

        if only_one_input_coordinate_claims_the_spot(distances, smallest_distance) do
          assign_spot_to_input_coordinate(assignments, from, spot)
        else
          assignments
        end
      end)

    {_, coordinates_assigned} = Enum.max_by(assignments, fn {_k, v} -> Enum.count(v) end)
    Enum.count(coordinates_assigned)
  end

  defp distances_from_a_to_many_coordinates(a, many_coordinates) do
    Enum.map(many_coordinates, fn coordinate ->
      {coordinate, manhattan_distance(coordinate, a)}
    end)
  end

  defp only_one_input_coordinate_claims_the_spot(distances, smallest_distance) do
    Enum.count(distances, fn {_from, distance} -> distance === smallest_distance end) === 1
  end

  defp assign_spot_to_input_coordinate(assignments, input_coordinate, spot) do
    Map.update(
      assignments,
      input_coordinate,
      MapSet.new([spot]),
      fn assigned_to_this_input_coord -> MapSet.put(assigned_to_this_input_coord, spot) end
    )
  end

  def part_two(input_coordinates, max_distance) do
    enclosing_area = enclosing_area(input_coordinates)

    Enum.filter(enclosing_area, fn potential_coordinate ->
      Enum.reduce(input_coordinates, 0, fn input_coordinate, total_distance ->
        total_distance + manhattan_distance(potential_coordinate, input_coordinate)
      end) < max_distance
    end)
    |> Enum.count()
  end

  defp manhattan_distance({x, y}, {other_x, other_y}) do
    Kernel.abs(x - other_x) + Kernel.abs(y - other_y)
  end

  def enclosing_area(coordinates) do
    {min_x, _} = Enum.min_by(coordinates, fn {x, _y} -> x end)
    {max_x, _} = Enum.max_by(coordinates, fn {x, _y} -> x end)
    {_, min_y} = Enum.min_by(coordinates, fn {_x, y} -> y end)
    {_, max_y} = Enum.max_by(coordinates, fn {_x, y} -> y end)

    for x <- min_x..max_x, y <- min_y..max_y, do: {x, y}
  end
end
