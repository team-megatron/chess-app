class GamesController < ApplicationController
  before_action :authenticate_player!
  def index
    @games = Game.all.sort_by{|game| game.id}
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

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    # shoud redirect to game#show
    # for now redirect to games#index
    redirect_to games_path
  end

  helper_method :white_player_email, :black_player_email, :isOpen?

  private

  def game_params
    params.require(:game).permit(:black_player_id)
  end
end
