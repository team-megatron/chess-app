class AlterPiecesAddCapturedField < ActiveRecord::Migration
  def change
    add_column :pieces, :captured, :boolean
  end
end
