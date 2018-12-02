defmodule Year2018.One do

  def part_one(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle()
    |> Enum.reduce_while([0], fn(item, acc) ->
      new_sum = item + Enum.at(acc, 0)
      if new_sum in acc do
        {:halt, new_sum}
      else
        {:cont, [item + Enum.at(acc, 0) | acc]}
      end
    end)
  end
end
