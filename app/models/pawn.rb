class Pawn < Piece
  def valid_move?(row_destination, col_destination)
    start_row = self.is_black? ? 7 : 2
    direction = self.is_black ? 1 : -1

    row_distance = self.row - row_destination
    col_distance = self.column - col_destination

    if self.row == start_row && self.column == col_destination
      return row_distance == 2 * direction || row_distance == 1 * direction
    elsif row_distance == 1 * direction && col_distance == 1 * direction
      return self.game.pieces.find_by(row: row_destination, column: col_destination, captured: false)
    elsif self.column == col_destination
      return row_distance == 1 * direction
    end
  end
end
