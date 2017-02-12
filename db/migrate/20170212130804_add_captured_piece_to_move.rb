class AddCapturedPieceToMove < ActiveRecord::Migration
  def change
    add_column :moves, :captured_piece_id, :integer
  end
end
