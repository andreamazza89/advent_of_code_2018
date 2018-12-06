defmodule Year2018.Three do
  alias Year2018.Three.Claim

  def part_one(input) do
    input
    |> Enum.map(&Claim.create/1)
    |> Enum.flat_map(&Claim.cells_covered/1)
    |> Enum.reduce(
      %{new: [], existing: []},
      &add_to_new_or_existing/2
    )
    |> Map.get(:existing)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp add_to_new_or_existing(cell, new_or_existing) do
    if cell in new_or_existing.new do
      Map.update(new_or_existing, :existing, [], &[cell | &1])
    else
      Map.update(new_or_existing, :new, [], &[cell | &1])
    end
  end

  def part_two(input) do
    claims = Enum.map(input, &Claim.create/1)

    stuff =
      claims
      |> Enum.reduce(
        %{losers: MapSet.new(), all_claims: MapSet.new(claims)},
        &check_if_winner_new/2
      )

    MapSet.difference(stuff.all_claims, stuff.losers)
    |> Enum.at(0)
    |> Map.get(:id)
  end

  defp check_if_winner_new(claim, accumulator) do
    all_claims_less_this_one = Enum.filter(accumulator.all_claims, fn other_claim ->
      claim !== other_claim
    end)
    if Enum.any?(all_claims_less_this_one, fn other_claim ->
      Claim.overlap?(claim, other_claim)
    end) do
      %{accumulator | losers: MapSet.put(accumulator.losers, claim)}
    else
      accumulator
    end
  end

  defmodule Claim do
    @enforce_keys [:x, :y, :width, :height, :id]
    defstruct [:x, :y, :width, :height, :id]

    def create(raw_input) do
      claim_regex = ~r{#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)}
      claim_info = Regex.named_captures(claim_regex, raw_input)

      %Claim{
        x: String.to_integer(claim_info["x"]),
        y: String.to_integer(claim_info["y"]),
        width: String.to_integer(claim_info["width"]),
        height: String.to_integer(claim_info["height"]),
        id: String.to_integer(claim_info["id"])
      }
    end

    def cells_covered(%Claim{x: x, y: y, width: width, height: height} = _claim) do
      for x_covered <- x..(x + width - 1), y_covered <- y..(y + height - 1) do
        {x_covered, y_covered}
      end
    end

    def overlap?(%Claim{} = claim, %Claim{} = other_claim) do
      !(MapSet.intersection(MapSet.new(Claim.cells_covered(claim)), MapSet.new(Claim.cells_covered(other_claim))) |> Enum.empty?())
    end
  end
end
