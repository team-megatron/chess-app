class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :pieces, :isSelected, :is_selected
  end
end
