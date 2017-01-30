class AlterMovesTable < ActiveRecord::Migration
  def change
    remove_column :moves, :move_string, :string
    add_column :moves, :piece_id, :integer
    add_column :moves, :start_row, :integer
    add_column :moves, :start_column, :integer
    add_column :moves, :end_row, :integer
    add_column :moves, :end_column, :integer
  end
end
