class AlterPieceAddCaptureColumn < ActiveRecord::Migration
  def change
    add_column :pieces, :captured, :boolean
  end
end
