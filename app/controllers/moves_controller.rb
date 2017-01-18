class MovesController < ApplicationController
  def create
    # TODO: check the move and any piece to be captured.
    # now assume the move is valid and the target square is empty,
    # move the piece and deselect it.
    pieces_selected = Piece.where(isSelected: true)
    if !pieces_selected.empty?
      piece = pieces_selected[0]

      # TODO: improve this simple move recording.
      move_string = "#{piece.type},"\
                    "r#{piece.row},c#{piece.column},"\
                    "r#{params[:row]},c#{params[:column]}"
      @move = Move.create(game_id: params[:game_id],
                          is_black: params[:is_black],
                          move_string: move_string)
      # update piece position
      piece.update_attributes(column: params[:column], row: params[:row],
                              isSelected: false)
      # refresh the chessboard
      redirect_to game_path(piece.game)
    end
  end

end
