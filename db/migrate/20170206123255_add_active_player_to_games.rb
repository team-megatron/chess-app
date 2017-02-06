class AddActivePlayerToGames < ActiveRecord::Migration
  def change
    add_column :games, :active_player_id, :integer, class_name: "Player"
    add_index :games, :active_player_id
  end
end
