class Pawn < Piece
  def valid_move?(row_destination, col_destination)
    start_row = self.is_black? ? 7 : 2
    direction = self.is_black ? 1 : -1

    if self.row == start_row
      return (self.row - row_destination) <= 2 * direction
    else
      return (self.row - row_destination) == 1 * direction
    end
  end
end
