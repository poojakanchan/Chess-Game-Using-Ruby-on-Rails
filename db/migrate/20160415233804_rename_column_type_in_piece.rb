class RenameColumnTypeInPiece < ActiveRecord::Migration

  def change
   rename_column :pieces, :type, :name

  end
end
