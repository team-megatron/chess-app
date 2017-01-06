class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.integer :type
      t.integer :row
      t.integer :column
      t.boolean :is_black

      t.timestamps
    end
    add_index :pieces, :game_id
  end
end
