defmodule Year2018.Two do
  def part_one(input) do
    total_doubles_and_triples =
      input
      |> Enum.map(&count_letters/1)
      |> Enum.reduce(%{doubles: 0, triples: 0}, fn letters_count, doubles_and_triples ->
        doubles_and_triples
        |> check_for_doubles(letters_count)
        |> check_for_triples(letters_count)
      end)

    total_doubles_and_triples[:doubles] * total_doubles_and_triples[:triples]
  end

  defp count_letters(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn letter, letters_count ->
      Map.update(letters_count, letter, 1, &(&1 + 1))
    end)
  end

  # these two 'checkers' could be refactored to a more generic one, but that makes it
  # less readable I think, so leaving as is
  defp check_for_doubles(total_doubles_and_triples, letters_count) do
    if Enum.any?(letters_count, fn {_letter, occurrences} -> occurrences == 2 end) do
      Map.update!(total_doubles_and_triples, :doubles, &(&1 + 1))
    else
      total_doubles_and_triples
    end
  end

  defp check_for_triples(total_doubles_and_triples, letters_count) do
    if Enum.any?(letters_count, fn {_letter, occurrences} -> occurrences == 3 end) do
      Map.update!(total_doubles_and_triples, :triples, &(&1 + 1))
    else
      total_doubles_and_triples
    end
  end

  def part_two(input) do
    character_differences =
      all_combinations_of_ids(input)
      |> Enum.map(fn {id_one, id_two} ->
        String.myers_difference(id_one, id_two)
      end)

    character_differences
    |> find_one_character_difference()
    |> Enum.filter(fn
      {:eq, _} -> true
      _ -> false
    end)
    |> Enum.reduce("", fn {:eq, shared_chunk}, shared_total -> shared_total <> shared_chunk end)
  end

  defp all_combinations_of_ids(ids) do
    for id_one <- ids, id_two <- ids, id_one !== id_two, do: {id_one, id_two}
  end

  defp find_one_character_difference(character_differences) do
    Enum.find(character_differences, fn difference ->
      deletes = Keyword.get_values(difference, :del)
      Enum.count(deletes) == 1 && String.length(Enum.at(deletes, 0)) == 1
    end)
  end
end
