defmodule Korigatachi.Game do
  alias Korigatachi.{Game, State}

  defstruct history: [%State{}], index: 0

  def state(%Game{history: history, index: index}) do
    Enum.at(history, index)
  end

  defp update_game(%Game{history: history, index: index} = game, function) do
    new_state =
      game
      |> Game.state()
      |> function.()

    %{game | history: [new_state | Enum.slice(history, index..-1)], index: 0}
  end

  def change_capture(%Game{history: history, index: index} = game, color, delta) do
    update_game(game, fn g -> State.change_capture(g, color, delta) end)
  end

  def change_current(%Game{history: history, index: index} = game, current) do
    update_game(game, fn g -> State.change_current(g, current) end)
  end

  def toggle(%Game{history: history, index: index} = game, position) do
    update_game(game, fn g -> State.toggle(g, position) end)
  end
end
