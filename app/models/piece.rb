class Piece < ActiveRecord::Base
  scope :active, -> { where captured: false }
  scope :captured, -> { where captured: true }

  require_relative 'helpers/piece_helper'
  include PieceHelper

  belongs_to :game

  def is_obstructed?(row_destination, col_destination)
    return true if is_obstructed_horizontally?(row_destination, col_destination)
    return true if is_obstructed_vertically?(row_destination, col_destination)
    return true if is_obstructed_diagonally?(row_destination, col_destination)
    return false
  end

  # Utilize helper methods to check validity of move, make the move, and record the move.
  def move_to(row_destination, col_destination)
    # If all checks pass, record the move, update piece position, and deselect the peice.
    self.record_move(row_destination, col_destination)
    self.update_attributes(column: col_destination, row: row_destination, is_selected: false)
  end
end
