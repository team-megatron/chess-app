class PiecesController < ApplicationController

  def show
    # if no piece is selected before, update current piece's is_selected
    # else if the same piece has been selected before, deselect it

    piece = Piece.find(params[:id])
    pieces_selected = Piece.where(is_selected: true, game_id: params[:game_id])
    if pieces_selected.empty?
      piece.update_attributes(is_selected: true)
    elsif pieces_selected[0].id == piece.id
      piece.update_attributes(is_selected: false)
    end
    redirect_to game_path(piece.game)
  end

  def update
    # TODO: check the move and any piece to be captured.
    # now assume the move is valid and the target square is empty,
    # move the piece and deselect it.
    piece = Piece.find(params[:id])
    if piece
      # update only when the position changes
      if piece.row != params[:row] && piece.column != params[:column]
        # TODO: improve this simple move recording.
        move_string = "#{piece.type},"\
                      "r#{piece.row},c#{piece.column},"\
                      "r#{params[:row]},c#{params[:column]}"
        @move = Move.create(game_id: params[:game_id],
                            is_black: params[:is_black],
                            move_string: move_string)
        # update piece position
        piece.update_attributes(column: params[:column], row: params[:row])
      end
      # deselect the piece
      piece.update_attributes(is_selected: false)
      # refresh the chessboard
      redirect_to game_path(piece.game)
    end
  end

end
