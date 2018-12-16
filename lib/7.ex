defmodule Year2018.Seven do
  alias Year2018.Seven.Steps

  # giving up on part two - having missed the fact that each worker is processing a whole step,
  # I think it's now too difficult to introduce this concept, so rather than starting from
  # scratch I shall move on to the next puzzle
  def part_two(instructions, base_time, no_of_workers) do
    steps = Steps.new(instructions, base_time)
    process_steps(steps, no_of_workers)
  end

  defp process_steps(steps, n_of_workers) do
    do_process_steps(steps, n_of_workers, 0)
  end

  defp do_process_steps(steps, n_of_workers, time) do
    case Steps.available(steps) do
      [] -> time - 1
      steps_available ->
        steps_to_process = Enum.take(steps_available, n_of_workers)
        steps_to_count_down = Enum.filter(steps_to_process, fn {_letter, count} ->
          count > 1
        end)
        |> Enum.map(fn {letter, _count} -> letter end)
        steps_to_delete = Enum.filter(steps_to_process, fn {_letter, count} ->
          count == 1
        end)
        |> Enum.map(fn {letter, _count} -> letter end)

        IO.inspect steps_available

        new_steps = Steps.count_down(steps, steps_to_count_down)
        |> Steps.delete(steps_to_delete)

        do_process_steps(new_steps, n_of_workers, time + 1)
    end
  end

  def part_one(instructions) do
    parsed_instructions = parse_instructions(instructions)
    order_instructions(parsed_instructions)
  end

  def parse_instructions(instructions) do
    Enum.reduce(instructions, [], fn instruction, parsed_instructions ->
      instruction_regex = ~r/Step (?<from>\w).* step (?<to>\w)/
      instruction_info = Regex.named_captures(instruction_regex, instruction)
      [{instruction_info["from"], instruction_info["to"]} | parsed_instructions]
    end)
  end

  def order_instructions(parsed_instructions) do
    do_order_instructions(parsed_instructions, "")
  end

  def do_order_instructions([{from, to}], result), do: result <> from <> to

  def do_order_instructions(remaining_instructions, result) do
    {froms, tos} =
      Enum.reduce(remaining_instructions, {MapSet.new(), MapSet.new()}, fn {from, to},
                                                                           {froms, tos} ->
        {MapSet.put(froms, from), MapSet.put(tos, to)}
      end)

    next_steps = MapSet.difference(froms, tos) |> MapSet.to_list() |> Enum.sort()

    updated_instructions =
      Enum.filter(remaining_instructions, fn {from, _to} ->
        from !== Enum.at(next_steps, 0)
      end)

    do_order_instructions(updated_instructions, result <> Enum.at(next_steps, 0))
  end

  defmodule Steps do
    def new(instructions, base_time) do
      steps_rules = Year2018.Seven.parse_instructions(instructions)

      steps_values =
        Enum.reduce(alphabet(), %{}, fn step_letter, steps_values ->
          Map.put(steps_values, step_letter, initial_step_length(step_letter, base_time))
        end)

      %{steps_rules: steps_rules, steps_values: steps_values}
    end

    defp alphabet(), do: for(n <- ?A..?Z, do: <<n::utf8>>)

    defp initial_step_length(<<step_letter::utf8>>, base_time) do
      # I am hardcoding the base 60 seconds. SoZ
      step_letter - 64 + base_time
    end

    def available(steps) do
      {froms, tos} =
        steps.steps_rules
        |> Enum.reduce({[], []}, fn {from, to}, {froms, tos} ->
          {[from | froms], [to | tos]}
        end)

      available_steps_ids =
        MapSet.difference(MapSet.new(froms), MapSet.new(tos))
        |> MapSet.to_list()
        |> Enum.sort()

      Enum.map(available_steps_ids, fn step_id ->
        step_value = Map.get(steps.steps_values, step_id)
        {step_id, step_value}
      end)
    end

    def count_down(steps, steps_to_count_down) do
      Enum.reduce(steps_to_count_down, steps, fn step_to_countdown, steps ->
        new_steps_values =
          Map.update!(steps.steps_values, step_to_countdown, fn value -> value - 1 end)

        %{steps | steps_values: new_steps_values}
      end)
    end

    def delete(steps, steps_to_delete) do
      Enum.reduce(steps_to_delete, steps, fn step_to_delete, steps ->
        if penultimate_step?(steps.steps_rules) do
          {_from, to} = Enum.at(steps.steps_rules, 0)
          new_steps_rules = [{to, :end}]
          %{steps | steps_rules: new_steps_rules}
        else
          new_steps_rules = remove_step_rule(steps.steps_rules, step_to_delete)
          %{steps | steps_rules: new_steps_rules}
        end
      end)
    end

    defp penultimate_step?([{_from, :end}]), do: false
    defp penultimate_step?([penultimate_step]), do: true
    defp penultimate_step?(_), do: false

    def remove_step_rule(steps_rules, step_to_remove) do
      Enum.filter(steps_rules, fn {from, _to} -> from !== step_to_remove end)
    end
  end
end
