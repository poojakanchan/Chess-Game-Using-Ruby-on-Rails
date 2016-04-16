class AddPieceReferenceToLocation < ActiveRecord::Migration
  def change
     add_column :locations,:piece_id,:integer
  end
end
