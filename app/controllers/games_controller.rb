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

  def create
    @game = Game.create(game_params)
    if @game.valid?
      @game.update_attributes(white_player_id: current_player.id,
                              active_player_id: current_player.id)
      @game.populate_game!

      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def reset
    @game = Game.find(params[:id])
    @game.reset_game!
    @game.update_attributes(active_player: @game.white_player)

    # refresh the page on local and remote client
    channel_name = 'game_channel_' + @game.id.to_s
    Pusher[channel_name].trigger('refresh', {})
    redirect_to game_path(@game)
  end

  private

  helper_method :white_player_email, :black_player_email, :is_open?

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

  def is_open?(game)
    game.black_player.blank?
  end

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end
end
