class Bishop < Piece
  include PieceHelper

  def valid_move?(row_dest_int, column_dest_int)
    if row_dest_int < 1 || row_dest_int > 8 ||
       column_dest_int < 1 || column_dest_int > 8
      return false
    end

    col_diff = self.column - column_dest_int
    row_diff = self.row - row_dest_int
    # invalid if not on diagonal lines or obstructed diagonally
    if col_diff.abs != row_diff.abs ||
       is_obstructed_diagonally?(row_dest_int, column_dest_int)
      return false
    end

    return true
  end

end
