class GamesController < ApplicationController
  before_action :authenticate_player!
  def index
    @games = Game.all
  end

  def white_player_email(game)
    if game.white_player.present?
      game.white_player.email
    else
      nil
    end
  end

  def black_player_email(game)
    if game.black_player.present?
      game.black_player.email
    else
      nil
    end
  end

  def isOpen?(game)
    game.black_player.blank?
  end

  helper_method :white_player_email, :black_player_email, :isOpen?
end
