module PieceHelper
  def is_obstructed_horizontally?(row_destination, col_destination)
    if self.row != row_destination
      return false
    end

    # Pull in all pieces from same game.
    pieces = self.game.pieces.where(row: self.row)

    # Establish which direction piece is moving.
    col_increment = self.column < col_destination ? 1 : -1
    next_column = self.column + col_increment

    while (next_column * col_increment) < (col_destination * col_increment)
      pieces.each do |piece|
        return true if piece.column == next_column
      end
      next_column += col_increment
    end

    return false
  end

  def is_obstructed_vertically?(row_destination, col_destination)
    if self.column != col_destination
      return false
    end

    # Pull in all game pieces
    pieces = self.game.pieces.where(column: self.column)

    row_increment = self.row < row_destination ? 1 : -1
    next_row = self.row + row_increment

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

    steps = []

    if self.row < row_destination
      next_row = self.row + 1
      # Check if moving up and right
      if self.column < col_destination
        ((self.column + 1)...col_destination).each do |col|
          steps << [next_row, col]
          next_row += 1
        end
      # Check if moving up and left
      else # Implied that self.column > col_destination
        ((col_destination + 1)...self.column).to_a.reverse.each do |col|
          steps << [next_row, col]
          next_row += 1
        end
      end
    else # Implied that self.row > row_destination
      next_row = self.row - 1
      # Check if moving down and right
      if self.column < col_destination
        ((self.column + 1)...col_destination).each do |col|
          steps << [next_row, col]
          next_row -= 1
        end
      # Check if moving down and left
      else # Implied that self.column > col_destination
        ((col_destination + 1)...self.column).to_a.reverse.each do |col|
          steps << [next_row, col]
          next_row -= 1
        end
      end
    end

    pieces = self.game.pieces
    pieces.each do |piece|
      steps.each do |row, column|
        if piece.row == row && piece.column == column
          return true
        end
      end
    end
    return false
  end
end
