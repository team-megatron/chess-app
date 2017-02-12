class Piece < ActiveRecord::Base
  scope :active, -> { where(captured: false) }
  scope :captured, -> { where(captured: true) }

  require_relative 'helpers/piece_helper'
  include PieceHelper

  belongs_to :game

  def valid_move?(row_destination, col_destination)
    # check if move to outside chessboard
    if row_destination < 1 || row_destination > 8 ||
       col_destination < 1 || col_destination > 8 ||
       has_same_piece_color?(row_destination, col_destination)
      return false
    end
    return true
  end

  def is_obstructed?(row_destination, col_destination)
    return true if is_obstructed_horizontally?(row_destination, col_destination)
    return true if is_obstructed_vertically?(row_destination, col_destination)
    return true if is_obstructed_diagonally?(row_destination, col_destination)
    return false
  end

  # Utilize helper methods to check validity of move, make and record the move,
  # and capture if appropriate.
  def move_to(row_destination, col_destination)
    # Capture piece located at target location if exists

    if capturable?(row_destination, col_destination)
      captured_piece = capture_piece(row_destination, col_destination)
    end
    # If all checks pass, record the move, update piece position, and deselect the piece.
    self.record_move(row_destination, col_destination)
    if !captured_piece.nil?
      last_move = self.game.moves.last
      last_move.update_attributes(captured_piece_id: captured_piece.id)
    end
    self.update_attributes(column: col_destination, row: row_destination, is_selected: false)
    move = {:type => 'normal',
            :piece => {:id => self.id, :end_row => row_destination, :end_column => col_destination}}
    return move
  end

  def is_promotable?
    return false
  end
end
