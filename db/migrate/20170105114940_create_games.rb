class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :white_player_id, class_name: "Player"
      t.integer :black_player_id, class_name: "Player"
      t.string :result

      t.timestamps
    end
    add_index :games, :white_player_id
    add_index :games, :black_player_id
  end
end
