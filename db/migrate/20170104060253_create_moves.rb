class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.boolean :is_black
      t.string :move_string
      t.integer :time_sec_lapse
      t.timestamps
    end
    add_index :moves, :game_id
  end
end
