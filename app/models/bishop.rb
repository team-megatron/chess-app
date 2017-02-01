class Bishop < Piece
  include PieceHelper

  def valid_move?(row_destination, col_destination)
    # check if move to outside chessboard
    return false if !super

    col_diff = self.column - col_destination
    row_diff = self.row - row_destination
    # invalid if not on diagonal lines or obstructed diagonally
    if col_diff.abs != row_diff.abs ||
       is_obstructed_diagonally?(row_destination, col_destination)
      return false
    end

    return true
  end

end
