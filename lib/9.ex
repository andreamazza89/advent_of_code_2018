defmodule Year2018.Nine do
  def part_one(no_of_players, last_marble) do
    initial_state = %{
        current_marble_index: 3,
        next_marble: 4,
        board: [0, 2, 1, 3],
        current_player: 3,
        scores: %{}
      }

    {_, highest} = do_part_one(initial_state, no_of_players, last_marble)
    highest
  end

  defp do_part_one(state, no_of_players, last_marble) do
    if state.next_marble > last_marble do
      Enum.max_by(state.scores, fn {_id, score} -> score end)
    else
      new_state = update_state(state, no_of_players)
      do_part_one(new_state, no_of_players, last_marble)
    end
  end

  def update_state(current_state, no_of_players) do
    if rem(current_state.next_marble, 23) === 0 do
      scoring_update(current_state, no_of_players)
    else
      standard_update(current_state, no_of_players)
    end
  end

  defp standard_update(current_state, no_of_players) do
    new_marble_index =
      wrap_around_clockwise(
        current_state.current_marble_index + 2,
        Enum.count(current_state.board)
      )

    new_board =
      Enum.take(current_state.board, new_marble_index) ++
        [current_state.next_marble] ++ Enum.drop(current_state.board, new_marble_index)

    new_player_id = wrap_around_clockwise(current_state.current_player + 1, no_of_players)

    %{
      current_marble_index: new_marble_index,
      next_marble: current_state.next_marble + 1,
      board: new_board,
      current_player: new_player_id,
      scores: current_state.scores
    }
  end

  defp scoring_update(current_state, no_of_players) do
    marble_to_remove_index =
      wrap_around_anti_clockwise(
        current_state.current_marble_index - 7,
        Enum.count(current_state.board)
      )

    new_board =
      Enum.take(current_state.board, marble_to_remove_index) ++
        Enum.drop(current_state.board, marble_to_remove_index + 1)

    new_player_id = wrap_around_clockwise(current_state.current_player + 1, no_of_players)

    score_for_this_round = current_state.next_marble + Enum.at(current_state.board, marble_to_remove_index)
    new_scores =
      Map.update(current_state.scores, new_player_id, score_for_this_round, fn score ->
        score + score_for_this_round
      end)

    %{
      current_marble_index: wrap_around_clockwise(marble_to_remove_index, Enum.count(new_board)),
      next_marble: current_state.next_marble + 1,
      board: new_board,
      current_player: new_player_id,
      scores: new_scores
    }
  end

  defp wrap_around_clockwise(index, max_allowed) when index > max_allowed do
    index - max_allowed
  end

  defp wrap_around_clockwise(index, _), do: index

  defp wrap_around_anti_clockwise(index, max_allowed) when index <= 0 do
    max_allowed + index
  end

  defp wrap_around_anti_clockwise(index, _), do: index
end
