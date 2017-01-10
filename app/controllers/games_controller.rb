class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def white_player_name(game)
    if game.white_player.present?
      game.white_player.name
    else
      nil
    end
  end

  def black_player_name(game)
    if game.black_player.present?
      game.black_player.name
    else
      nil
    end
  end

  def isOpen?(game)
    game.black_player.blank?
  end

  helper_method :white_player_name, :black_player_name, :isOpen?
end
