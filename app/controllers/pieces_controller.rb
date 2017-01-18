class PiecesController < ApplicationController

  def show
    # if no piece is selected before, update current piece's is_selected
    # else if the same piece has been selected before, deselect it

    piece = Piece.find(params[:id])
    pieces_selected = Piece.where(is_selected: true)
    if pieces_selected.empty?
      piece.update_attributes(is_selected: true)
    elsif pieces_selected[0].id == piece.id
      piece.update_attributes(is_selected: false)
    end
    redirect_to game_path(piece.game)
  end

end
