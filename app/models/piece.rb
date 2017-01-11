class Piece < ActiveRecord::Base
  belongs_to :game

  def is_obstructed?(row_destination, col_destination)
    if is_moving_horizontal?(row_destination)
      is_obstructed_horizontally?(col_destination)
    end
  end

  def is_moving_horizontal?(row_destination)
    if self.row == row_destination
      return true
    end
  end

  def is_obstructed_horizontally?(col_destination)
    #steps array is the location between piece and destination
    steps = []
    #find the spots in between piece and destination
    if self.column < col_destination
      ((self.column + 1)...col_destination).each do |col|
        steps << col
      end
    else
      ((col_destination + 1)...self.column).each do |col|
        steps << col
      end
    end

    pieces = self.game.pieces
    pieces.each do |piece|
      steps.each do |step|
        if self.row == piece.row && piece.column == step
          return true
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

  def is_obstructed_diagonally?(row_destination, col_destination)
    steps = []
    column = []
    ((self.column + 1)...col_destination).each do |col|
      column << col
    end

    count = self.row + 1
    column.each do |column|
      steps << [count, column]
      count += 1
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
