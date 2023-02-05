defmodule Korigatachi.State do
  alias Korigatachi.State

  defstruct positions: Enum.map(1..81, fn _ -> nil end),
            current: :black,
            captures: %{black: 0, white: 0}

  def change_capture(%State{captures: captures} = state, color, delta) do
    new_captures = Map.update(captures, color, 0, fn x -> max(0, x + delta) end)
    %{state | captures: new_captures}
  end

  def change_current(state, current) do
    %{state | current: current}
  end

  def toggle(%State{positions: positions, current: current} = state, index) do
    at_index = Enum.at(positions, index)
    replace = if at_index == current, do: nil, else: current

    new_positions = List.replace_at(positions, index, replace)
    %{state | positions: new_positions}
  end

  def get_score(%State{positions: positions}) do
    %{black: 0, white: 0}
  end
end
