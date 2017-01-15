class AlterPieceTableChangeTypefieldType < ActiveRecord::Migration
  def change
    change_column :pieces, :type, :string
  end
end
