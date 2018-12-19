defmodule Year2018Test.Nine do
  use ExUnit.Case

  describe "game updates" do
    test "easy" do
      current_state = %{
        current_marble_index: 1,
        next_marble: 5,
        board: [0, 4, 2, 1, 3],
        current_player: 5,
        scores: %{}
      }

      expected_new_state = %{
        current_marble_index: 3,
        next_marble: 6,
        board: [0, 4, 2, 5, 1, 3],
        current_player: 6,
        scores: %{}
      }

      assert Year2018.Nine.update_state(current_state, 9) === expected_new_state
    end

    test "marble wraps around" do
      current_state = %{
        current_marble_index: 3,
        next_marble: 4,
        board: [0, 2, 1, 3],
        current_player: 3,
        scores: %{}
      }

      expected_new_state = %{
        current_marble_index: 1,
        next_marble: 5,
        board: [0, 4, 2, 1, 3],
        current_player: 4,
        scores: %{}
      }

      assert Year2018.Nine.update_state(current_state, 9) === expected_new_state
    end

    test "marble goes at the end" do
      current_state = %{
        current_marble_index: 1,
        next_marble: 3,
        board: [0, 2, 1],
        current_player: 2,
        scores: %{}
      }

      expected_new_state = %{
        current_marble_index: 3,
        board: [0, 2, 1, 3],
        next_marble: 4,
        current_player: 3,
        scores: %{}
      }

      assert Year2018.Nine.update_state(current_state, 9) === expected_new_state
    end

    test "player wraps around" do
      current_state = %{
        current_marble_index: 3,
        next_marble: 10,
        board: [0, 8, 4, 9, 2, 5, 1, 6, 3, 7],
        current_player: 9,
        scores: %{}
      }

      expected_new_state = %{
        current_marble_index: 5,
        next_marble: 11,
        board: [0, 8, 4, 9, 2, 10, 5, 1, 6, 3, 7],
        current_player: 1,
        scores: %{}
      }

      assert Year2018.Nine.update_state(current_state, 9) === expected_new_state
    end

    test "player scores" do
      current_state = %{
        current_marble_index: 13,
        next_marble: 23,
        board: [0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
        current_player: 4,
        scores: %{}
      }

      expected_new_state = %{
        current_marble_index: 6,
        next_marble: 24,
        board: [0, 16, 8, 17,  4, 18, 19, 2, 20, 10, 21,  5, 22, 11, 1, 12,  6, 13,  3, 14,  7, 15],
        current_player: 5,
        scores: %{ 5 => 32 }
      }

      assert Year2018.Nine.update_state(current_state, 9) === expected_new_state
    end
  end

  test "online example" do
    high_score = Year2018.Nine.part_one(10, 1618)

    assert high_score === 8317
  end

  test "solves part one" do
    IO.puts("\n--------------------")
    IO.puts("solution to day nine part one:")

    Year2018.Nine.part_one(423, 71944)
    |> IO.inspect()
  end
end
