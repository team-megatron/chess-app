class Knight < Piece
  def valid_move?(row_destination, col_destination)
    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    [1, 2] == [row_diff, col_diff] || [2, 1] == [row_diff, col_diff]
  end
end
