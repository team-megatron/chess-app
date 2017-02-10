class PiecesController < ApplicationController
  before_action :current_piece, only: [:show, :update]

  def show
    # if no piece is selected before, update current piece's is_selected
    # else if the same piece has been selected before, deselect it

    pieces_selected = Piece.where(is_selected: true, game_id: params[:game_id])
    if pieces_selected.empty?
      current_piece.update_attributes(is_selected: true)
    elsif pieces_selected[0].id == piece.id
      current_piece.update_attributes(is_selected: false)
    end
    redirect_to game_path(current_piece.game)
  end

  def update
    # check if current_player can make the move
    # or selects the right piece color
    # or the move is valid
    if (current_player.id == active_player.id &&
        current_piece.is_black == (active_player.id == black_player.id) &&
        current_piece.valid_move?(params[:row].to_i, params[:column].to_i))
      # save old position before moving
      old_row = current_piece.row
      old_column = current_piece.column
      # Update the pieces row / column pair
      current_piece.move_to(params[:row], params[:column])
      # Update the pieces type if it is promotable
      current_piece.promote(params[:new_type]) if current_piece.is_promotable?
      
      # swap active player
      if current_piece.game.active_player == current_piece.game.white_player
        current_piece.game.update_attributes(active_player: current_piece.game.black_player)
      else
        current_piece.game.update_attributes(active_player: current_piece.game.white_player)
      end

      # inform of successful move
      channel_name = 'game_channel_' + current_piece.game.id.to_s
      puts channel_name
      Pusher['game_channel_' + current_piece.game.id.to_s].trigger('move', {
        :old_row => old_row, :old_column => old_row,
        :new_row => params[:row], :new_column => params[:column],
        :piece_id => current_piece.id
      })
      # Return back the current_piece data to user
      render json: current_piece
    else
      render json: {}
    end
  end

  private

    def current_piece
      @current_piece ||= Piece.find(params[:id])
    end

    def current_player
      @current_player ||= Player.find(params[:current_player_id])
    end

    def active_player
      @active_player ||= Player.find(current_piece.game.active_player_id)
    end

    def black_player
      @black_player ||= current_piece.game.black_player
    end

    def is_actual_move?(row_destination, col_destination)
      current_piece.row != row_destination || current_piece.column != col_destination
    end
end
