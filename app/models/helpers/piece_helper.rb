module PieceHelper
  def is_obstructed_horizontally?(row_destination, col_destination)
    if self.row != row_destination
      return false
    end

    incrementing = self.column < col_destination
    start_column = self.column + (incrementing ? 1 : -1)
    end_column = col_destination + (incrementing ? -1 : 1)

    if incrementing
      self.game.pieces.where(row: self.row, column: (start_column..end_column)).exists?
    else
      self.game.pieces.where(row: self.row, column: (end_column..start_column)).exists?
    end
  end

  def is_obstructed_vertically?(row_destination, col_destination)
    if self.column != col_destination
      return false
    end

    incrementing = self.row < row_destination
    start_row = self.row + (incrementing ? 1 : -1)
    end_row = row_destination + (incrementing ? -1 : 1)

    if incrementing
      self.game.pieces.where(column: self.column, row: (start_row..end_row)).exists?
    else
      self.game.pieces.where(column: self.column, row: (end_row..start_row)).exists?
    end
  end

  def is_obstructed_diagonally?(row_destination, col_destination)
    if self.row == row_destination || self.column == col_destination
      return false
    end

    pieces = self.game.pieces

    # Establish which x and y direction piece is moving
    row_increment = self.row < row_destination ? 1 : -1
    col_increment = self.column < col_destination ? 1 : -1

    next_row = self.row + row_increment
    next_column = self.column + col_increment

    # Loop through all row / column pairs between start and end position.
    # Return true if any pieces on the row exist at specified pair.
    # (* col_increment) is done to allow < to always be correct operand.
    while (next_column * col_increment) < (col_destination * col_increment)
      pieces.each do |piece|
        return true if piece.row == next_row && piece.column == next_column
      end
      next_column += col_increment
      next_row += row_increment
    end

    return false
  end

  def record_move(row_destination, col_destination)
    # Record the game leveraging the relationship of piece->game->moves
    self.game.moves.create(
      is_black: self.is_black,
      piece_id: self.id,
      start_row: self.row,
      start_column: self.column,
      end_row: row_destination,
      end_column: col_destination,
      )
  end

  def capturable?(row_destination, col_destination)
    # Return true if an opponent piece exists at the specific location
    return self.game.pieces.active.exists?(row: row_destination, column:col_destination, is_black: !self.is_black)
  end

  def capture_piece(row_destination, col_destination)
    # Select opponent piece and set captured field to true
    piece = self.game.pieces.active.find_by(row: row_destination, column: col_destination, is_black: !self.is_black)
    piece.update_attribute :captured, true
  end
end
