class GamesController < ApplicationController
  before_action :authenticate_player!

  def new
    @game = Game.new
  end

  def show
    @game = current_game
    return render_not_found if @game.blank?
  end

  def index
    @games = Game.all.sort_by{|game| game.id}
  end

  def update
    current_game.update_attributes(game_params)
    # shoud redirect to game#show
    # for now redirect to games#index
    redirect_to games_path(current_game)
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
    if can_play?(current_player)
      current_game.reset_game!
      current_game.update_attributes(active_player: current_game.white_player)

      # refresh the page on local and remote client
      channel_name = 'game_channel_' + current_game.id.to_s
      Pusher[channel_name].trigger('refresh', {})
      redirect_to game_path(current_game)
    end
  end

  def undo
    # undo last move
    while can_play?(current_player) && (current_game.moves.last&.is_black == is_black?(current_player))
      undone_move = current_game.undo_last_move!
      current_game.update_attributes(active_player: current_player)

      # refresh the page on local and remote client
      channel_name = 'game_channel_' + current_game.id.to_s
      Pusher[channel_name].trigger(undone_move[:type], undone_move)
    end
    redirect_to game_path(current_game)
  end

  private

  helper_method :white_player_email, :black_player_email, :is_open?

  def current_game
    @current_game ||= Game.find_by_id(params[:id])
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

  def is_open?(game)
    game.black_player.blank?
  end

  def can_play?(player)
    return player == current_game.white_player || player == current_game.black_player
  end

  def is_black?(player)
    return player == current_game.black_player
  end

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end
end
