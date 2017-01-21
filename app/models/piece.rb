class Piece < ActiveRecord::Base
  require_relative 'helpers/piece_helper'
  include PieceHelper

  belongs_to :game

  def is_obstructed?(row_destination, col_destination)
    return true if is_obstructed_horizontally?(row_destination, col_destination)
    return true if is_obstructed_vertically?(row_destination, col_destination)
    return true if is_obstructed_diagonally?(row_destination, col_destination)
    return false
  end

  def move_to(row_destination, col_destination)
    # update piece position and deselect the piece
    self.record_move(row_destination, col_destination)
    self.update_attributes(column: col_destination, row: row_destination, is_selected: false)
  end
end
