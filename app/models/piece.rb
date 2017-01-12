class Piece < ActiveRecord::Base
  require_relative 'helpers/piece_helper'
  include PieceHelper

  belongs_to :game

  def is_obstructed?(row_destination, col_destination)
    if is_moving_horizontal?(row_destination)
      is_obstructed_horizontally?(col_destination)
    elsif is_moving_vertical?(col_destination)
      is_obstructed_vertically?(row_destination)
    else
      is_obstructed_diagonally?(row_destination, col_destination)
    end
  end
end
