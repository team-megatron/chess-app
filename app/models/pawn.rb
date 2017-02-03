class Pawn < Piece
  def valid_move?(row_destination, col_destination)
    # check if move to outside chessboard
    return false if !super

    # Check if move destination is obstructed by another piece
    return false if is_obstructed?(row_destination, col_destination)

    # Determine start row, and allowed move direction depending on piece color
    start_row = self.is_black? ? 7 : 2
    direction = self.is_black ? 1 : -1

    if valid_en_passant?(row_destination, col_destination)
      capture_piece((row_destination + (1 * direction)), col_destination)
      return true
    end

    # Determine vertical and horizontal move distance
    row_distance = self.row - row_destination
    col_distance = self.column - col_destination

    if self.row == start_row && self.column == col_destination
      # Horizontal distance moved can be 1 or 2 squares if the piece is on it's starting row.
      return row_distance == 2 * direction || row_distance == 1 * direction
    elsif row_distance == 1 * direction && col_distance.abs == 1
      # One distance diagonal moves allowed if opponent piece resides on square.
      return self.game.pieces.where(row: row_destination, column: col_destination, is_black: !self.is_black).exists?
    elsif self.column == col_destination
      # Piece can only move one square if not on starting row.
      return row_distance == 1 * direction
    end

    # If all other tests fail, assume false
    return false
  end

  def is_promotable?
    promotion_row = self.is_black? ? 1 : 8
    return self.row == promotion_row
  end

  def promote(new_type)
    self.update_attributes(type: new_type.downcase.capitalize)
  end
  def same_row_ep?
    correct_row = (self.is_black? ? 4 : 5)
    correct_row == self.game.moves.last.end_row
  end

  def same_column_ep?(col_destination)
    (self.game.moves.last.end_column - col_destination) == 0
  end

  def two_step_move?
    (self.game.moves.last.start_row - self.game.moves.last.end_row).abs == 2
  end

  def last_move_is_a_pawn?
    id = self.game.moves.last.piece_id
    self.game.pieces.find_by(id: id).type == "Pawn"
  end

  def correct_direction(row_destination)
    correct_direction = (self.is_black? ? 3 : 6)
    correct_direction == row_destination
  end

  def is_first_move?
    self.game.moves.empty?
  end

  def valid_en_passant?(row_destination, col_destination)
    return false if is_first_move?
    same_row_ep? && same_column_ep?(col_destination) && two_step_move? && last_move_is_a_pawn? && correct_direction(row_destination)
  end

end
