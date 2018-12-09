defmodule Year2018.Five do
  def part_one(input) do
    process_reactions(input)
  end

  def part_two(input) do
    alphabet
    |> Enum.map(fn letter_to_remove ->
      String.replace(input, ~r/#{letter_to_remove}/i, "")
    end)
    |> Enum.map(&process_reactions/1)
    |> Enum.min_by(&String.length/1)
  end

  defp alphabet() do
    for letter <- ?a..?z, do: << letter :: utf8 >>
  end

  def process_reactions(polymer) do
    polymer
    |> String.split("", trim: true)
    |> do_process_reactions([], continue: false)
  end

  defp do_process_reactions([], processed, continue: false) do
    List.to_string(Enum.reverse(processed))
  end

  defp do_process_reactions([], processed, continue: true) do
    do_process_reactions(Enum.reverse(processed), [], continue: false)
  end

  defp do_process_reactions([last_to_process], processed, should_continue) do
    do_process_reactions([], [last_to_process | processed], should_continue)
  end

  defp do_process_reactions([first | [second | rest]], processed, should_continue) do
    if reaction?(first, second) do
      do_process_reactions(rest, processed, continue: true)
    else
      do_process_reactions([second | rest], [first | processed], should_continue)
    end
  end

  defp reaction?(unit_one, unit_two) do
    upper_lower_or_lower_upper = ~r{([[:upper:]][[:lower:]]|[[:lower:]][[:upper:]])}
    same_letter = ~r{(.)\1}i

    Regex.match?(upper_lower_or_lower_upper, unit_one <> unit_two) &&
      Regex.match?(same_letter, unit_one <> unit_two)
  end
end
