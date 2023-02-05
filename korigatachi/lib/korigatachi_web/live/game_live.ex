defmodule KorigatachiWeb.GameLive do
  alias Korigatachi.Game

  use Phoenix.LiveView

  def render(assigns) do
    KorigatachiWeb.GameView.render("game.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    game = %Game{}
    {:ok, assign(socket, game: game, state: Game.state(game), score: %{black: 0, white: 0})}
  end

  def handle_event("change_capture", %{"color" => color, "delta" => delta}, %{assigns: assigns} = socket) do
    new_game = Game.change_capture(assigns.game, String.to_atom(color), String.to_integer(delta))
    {:noreply, assign(socket, game: new_game, state: Game.state(new_game))}
  end

  def handle_event("change_current", %{"current" => current}, %{assigns: assigns} = socket) do
    new_game = Game.change_current(assigns.game, String.to_atom(current))
    {:noreply, assign(socket, game: new_game, state: Game.state(new_game))}
  end

  def handle_event("toggle", %{"index" => index}, %{assigns: assigns} = socket) do
    new_game = Game.toggle(assigns.game, String.to_integer(index))
    {:noreply, assign(socket, game: new_game, state: Game.state(new_game))}
  end

  def handle_event("update_score", _args, %{assigns: assigns} = socket) do
    new_score = Game.get_score(assigns.game)
    {:noreply, assign(socket, score: new_score)}
  end
end
