class King < Piece

  def valid_move?(row_destination, col_destination)

    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    if (row_diff <= 1) && (col_diff <= 1)
      return true
    end

    return false
  end

  def can_castle?()

  end

  def castle(row_destination, col_destination)

  end
end
