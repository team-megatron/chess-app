class Rook < Piece

  def valid_move?(row_destination, col_destination)
    #first check for obstruction
    if is_obstructed?(row_destination, col_destination)
      return false
    end

    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    #horizontal only move
    if row_diff == 0 && col_diff > 0
      return true
    #vertical only move
    elsif row_diff > 0 && col_diff == 0
      return true
    else
      return false
    end
  end

end
