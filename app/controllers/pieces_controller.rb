class PiecesController < ApplicationController

  def show
    # if no piece is selected before, update current piece's isSelected
    # else if the same piece has been selected before, deselect it

    piece = Piece.find(params[:id])
    piecesSelected = Piece.where(isSelected: true)
    if piecesSelected.empty?
      piece.update_attributes(isSelected: true)
    elsif piecesSelected[0].id == piece.id
      piece.update_attributes(isSelected: false)
    end
    redirect_to game_path(piece.game)
  end

end
