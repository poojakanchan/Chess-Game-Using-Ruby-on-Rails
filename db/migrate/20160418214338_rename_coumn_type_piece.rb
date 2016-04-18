class RenameCoumnTypePiece < ActiveRecord::Migration
  def change
    change_column :pieces,:image,:string
  end
end
