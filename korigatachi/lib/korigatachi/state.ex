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
    cells = Enum.filter(0..80, fn k -> Enum.at(positions, k) == nil end)
    IO.inspect(cells)
    %{black: 0, white: 0}
  end

  defp get_score_from(positions, i) do

  end

  defp flood_fill(positions, i) do
    flood_fill(positions, [i], MapSet.new([i]), MapSet.new())
  end

  defp flood_fill(positions, [], visited, visited_color) do
    {visited, visited_color}
  end

  defp flood_fill(positions, to_visit, visited, visited_color) do
    {i, rest_to_visit} =
      case to_visit do
        [i] -> {i, []}
        [i | rest] -> {i, rest}
      end

    neighbors = neighbors_idx(i) |> Enum.map(fn k -> {k, Enum.at(positions, k)} end)

    next_visit =
      neighbors
      |> Enum.filter(fn {k, v} -> v == nil end)
      |> Enum.map(fn {k, v} -> k end)
      |> Enum.into(MapSet.new())
      |> MapSet.union(MapSet.new(to_visit))
      |> MapSet.difference(visited)
      |> MapSet.to_list()

    new_color =
      neighbors
      |> Enum.filter(fn {k, v} -> v != nil end)
      |> Enum.map(fn {k, v} -> v end)
      |> Enum.into(MapSet.new())

    flood_fill(positions, next_visit, MapSet.put(visited, i), MapSet.union(visited_color, new_color))
  end

  defp neighbors_idx(i) do
    {x, y} = i_to_xy(i)
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn {xx, yy} -> xx >= 0 and xx <= 8 and yy >= 0 and yy <= 8 end)
    |> Enum.map(fn p -> xy_to_i(p) end)
  end

  defp xy_to_i({x, y}) do
    y * 9 + x
  end

  defp i_to_xy(i) do
    {rem(i, 9), div(i, 9)}
  end
end
