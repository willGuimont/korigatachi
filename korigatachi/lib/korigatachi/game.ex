defmodule Korigatachi.Game do
  alias Korigatachi.{Game, State}

  defstruct history: [%State{}], index: 0

  def state(%Game{history: history, index: index}) do
    Enum.at(history, index)
  end

  def toggle(%Game{history: history, index: index} = game, position) do
    new_state =
      game
      |> Game.state()
      |> State.toggle(position)

    %{game | history: [new_state | Enum.slice(history, index..-1)], index: 0}
  end
end
