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

    # Pull from db pieces from same game and same column
    pieces = self.game.pieces.where(column: self.column)

    # Determine if piece is moving up or down
    row_increment = self.row < row_destination ? 1 : -1
    next_row = self.row + row_increment

    # Loop through all rows between start and end position.
    # Return true if any pieces on the column exist at specified row.
    # (* row_increment) is done to allow < to always be correct operand.
    while (next_row * row_increment) < (row_destination * row_increment)
      pieces.each do |piece|
        return true if piece.row == next_row
      end
      next_row += row_increment
    end

    return false
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
end
