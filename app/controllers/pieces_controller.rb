class PiecesController < ApplicationController

  def show
    # if no piece is selected before, update current piece's isSelected
    # else if the same piece has been selected before, deselect it

    piece = Piece.find(params[:id])
    pieces_selected = Piece.where(isSelected: true)
    if pieces_selected.empty?
      piece.update_attributes(isSelected: true)
    elsif pieces_selected[0].id == piece.id
      piece.update_attributes(isSelected: false)
    end
    redirect_to game_path(piece.game)
  end

end
