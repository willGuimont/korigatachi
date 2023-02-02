defmodule Korigatachi.State do
  alias Korigatachi.State

  defstruct positions: Enum.map(1..81, fn _ -> nil end),
            current: :black,
            captures: %{black: 0, white: 0}

  def toggle(%State{positions: positions, current: current, captures: captures} = state, index) do
    at_index = Enum.at(positions, index)
    replace = if at_index == current, do: nil, else: current

    new_positions = List.replace_at(positions, index, replace)
    %{state | positions: new_positions}
  end
end
