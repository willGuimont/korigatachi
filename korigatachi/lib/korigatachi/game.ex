defmodule Korigatachi.Game do
  alias Korigatachi.{Game, State}

  defstruct history: [%State{}], history_index: 0

  def state(%Game{history: history, history_index: history_index}) do
    Enum.at(history, history_index)
  end

  defp update_game(%Game{history: history, history_index: history_index} = game, function) do
    new_state =
      game
      |> Game.state()
      |> function.()

    %{game | history: [new_state | Enum.slice(history, history_index..-1)], history_index: 0}
  end

  defp update_state(%Game{history: history, history_index: history_index} = game, function) do
    new_state =
      game
      |> Game.state()
      |> function.()

    %{game | history: [new_state | Enum.slice(history, (history_index + 1)..-1)], history_index: 0}
  end

  def change_capture(game, color, delta) do
    update_state(game, fn g -> State.change_capture(g, color, delta) end)
  end

  def change_komi(game, color, delta) do
    update_state(game, fn g -> State.change_komi(g, color, delta) end)
  end

  def change_current(game, current) do
    update_state(game, fn g -> State.change_current(g, current) end)
  end

  def toggle(game, position) do
    update_state(game, fn g -> State.toggle(g, position) end)
  end

  def get_score(game) do
    game
    |> Game.state()
    |> State.get_score()
  end
end
