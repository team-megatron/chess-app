class GamesController < ApplicationController
  before_action :authenticate_player!
  def new
    @game = Game.new
  end

  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?
  end

  def index
    @games = Game.all.sort_by{|game| game.id}
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    # shoud redirect to game#show
    # for now redirect to games#index
    redirect_to games_path
  end

  private

  helper_method :white_player_email, :black_player_email, :isOpen?

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

  def game_params
    params.require(:game).permit(:black_player_id)
  end
end
