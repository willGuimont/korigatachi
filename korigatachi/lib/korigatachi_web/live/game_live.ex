defmodule KorigatachiWeb.GameLive do
  alias Korigatachi.Game

  use Phoenix.LiveView

  def render(assigns) do
    KorigatachiWeb.GameView.render("game.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    game = %Game{}
    {:ok, assign(socket, game: game, state: Game.state(game))}
  end

  def handle_event("toggle", %{"index" => index}, %{assigns: assigns} = socket) do
    new_game = Game.toggle(assigns.game, String.to_integer(index))
    {:noreply, assign(socket, game: new_game, state: Game.state(new_game))}
  end
end
