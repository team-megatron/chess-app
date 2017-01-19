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

  def capture_piece(row_destination, col_destination)
    capture = Piece.where(row: row_destination, column:col_destination, is_black: !self.is_black, game_id: self.game_id)
    if capture.exists?
      capture[0].update_attributes(captured:true)
    end
  end
end
