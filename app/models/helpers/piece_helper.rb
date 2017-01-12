module PieceHelper
  def is_moving_horizontal?(row_destination)
    if self.row == row_destination
      return true
    end
  end

  def is_obstructed_horizontally?(col_destination)
    # Pull in all pieces from same game.
    pieces = self.game.pieces

    #find the spots in between piece and destination
    if self.column < col_destination
      ((self.column + 1)...col_destination).each do |col|
        pieces.each do |piece|
          return true if self.row == piece.row && piece.column == col
        end
      end
    else
      ((col_destination + 1)...self.column).each do |col|
        pieces.each do |piece|
          return true if self.row == piece.row && piece.column == col
        end
      end
    end

    return false
  end

  def is_moving_vertical?(col_destination)
    if self.column == col_destination
      return true
    end
  end

  def is_obstructed_vertically?(row_destination)
    # Pull in all game pieces
    pieces = self.game.pieces

    if self.row < row_destination
      ((self.row + 1)...row_destination).each do |row|
        pieces.each do |piece|
          return true if self.column == piece.column && piece.row == row
        end
      end
    else
      ((row_destination + 1)...self.row).each do |row|
        pieces.each do |piece|
          return true if self.column == piece.column && piece.row == row
        end
      end
    end

    return false
  end

  def is_obstructed_diagonally?(row_destination, col_destination)
    steps = []
    # Check if moving up and right
    if self.row < row_destination && self.column < col_destination
      next_row = self.row + 1
      ((self.column + 1)...col_destination).each do |col|
        steps << [next_row, col]
        next_row += 1
      end
    # Check if moving down and right
    elsif self.row > row_destination && self.column < col_destination
      next_row = self.row - 1
      ((self.column + 1)...col_destination).each do |col|
        steps << [next_row, col]
        next_row -= 1
      end
    # Check if moving up and left
    elsif self.row < row_destination && self.column > col_destination
      next_row = self.row + 1
      ((col_destination + 1)...self.column).to_a.reverse.each do |col|
        steps << [next_row, col]
        next_row += 1
      end
    # Check if moving down and left
    elsif self.row > row_destination && self.column > col_destination
      next_row = self.row - 1
      ((col_destination + 1)...self.column).to_a.reverse.each do |col|
        steps << [next_row, col]
        next_row -= 1
      end
    end

    pieces = self.game.pieces
    pieces.each do |piece|
      puts steps.inspect
      steps.each do |row, column|
        if piece.row == row && piece.column == column
          return true
        end
      end
    end
    return false
  end
end
