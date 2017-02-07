class King < Piece

  def valid_move?(row_destination, col_destination)
    # Check for possible castle move first to avoid failure due to
    # has_same_piece_color? check.
    return true if can_castle?(row_destination, col_destination)

    # check if move to outside chessboard
    return false if !super

    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs

    if (row_diff <= 1) && (col_diff <= 1)
      return true
    end

    return false
  end

  def can_castle?(row_destination, col_destination)
    # Determine if there is a rook at the end of the board
    # Return false if there isn't
    target_rook = self.game.pieces.active.find_by(row: row_destination, column: col_destination, type: 'Rook')
    return false unless target_rook

    # Grab the current moves that have been made within a game.
    # Return false if either the king or rook have already moved.
    moves = self.game.moves
    return false if moves.exists?(piece_id: self.id) || moves.exists?(piece_id: target_rook.id)

    # Return fasle if there is a piece between the king and rook
    return false if is_obstructed?(target_rook.row, target_rook.column)

    # Return true if neither of the above tests fail
    return true
  end

  # If a king is castling, do not call super
  # If a king is not castling, call super
  def move_to(row_destination, col_destination)
    if can_castle?(row_destination, col_destination)
      rook = self.game.pieces.active.find_by(row: row_destination, column: col_destination)

      # Determine if the king is castling left or right
      direction = col_destination > self.column ? 1 : -1

      # Using direction, determine what row the king and rook belong on
      king_column = self.column + (2 * direction)
      rook_column = king_column + (1 * (direction * -1))

      # Update the king and rook using these newly found columns
      self.update_attributes(column: king_column)
      rook.update_attributes(column: rook_column)

      # Record the moves. This will end up looking like two consecutive moves
      # due to how table implementation. Nice to have would be a figuring out
      # how to record this specifically as a castle move.
      self.record_move(row_destination, king_column)
      rook.record_move(row_destination, rook_column)
      move = {:type => 'castling',
              :king => {:id => self.id, :end_row => self.row, :end_column => king_column},
              :rook => {:id => rook.id, :end_row => rook.row, :end_column => rook_column} }
      return move
    else
      return super
    end
  end
end
