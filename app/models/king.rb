class King < Piece

  def valid_move?(row_destination, col_destination)
    # check if move to outside chessboard
    return false if !super

    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    if (row_diff <= 1) && (col_diff <= 1)
      return true
    end

    return false
  end

end
