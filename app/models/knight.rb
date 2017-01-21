class Knight < Piece
  def valid_move?(row_destination, col_destination)
    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    (row_diff / col_diff) == 2 || (col_diff / row_diff) == 2 ? true : false
  end
end
