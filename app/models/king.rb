class King < Piece

  def valid_move?(row_destination, col_destination)
    # check if move to outside chessboard
    return false if !super

    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    if (row_diff <= 1) && (col_diff <= 1)
      return true
    end

    return false
  end

  def can_castle?(target_rook)
    # Grab the current moves that have been made within a game.
    # Return false if either the king or rook have already moved.
    moves = self.game.moves
    return false if moves.exists?(piece_id: self.id) || moves.exists?(piece_id: target_rook.id)

    # Return fasle if there is a piece between the king and rook
    return false if is_obstructed?(target_rook.row, target_rook.column)

    # Return true if neither of the above tests fail
    return true
  end

  def castle(row_destination, col_destination)

  end
end
