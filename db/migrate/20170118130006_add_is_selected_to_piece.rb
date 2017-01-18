class AddIsSelectedToPiece < ActiveRecord::Migration
  def change
    add_column :pieces, :isSelected, :boolean
  end
end
