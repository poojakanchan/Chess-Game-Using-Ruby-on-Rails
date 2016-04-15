class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :type
      t.binary :image
      t.integer :row
      t.integer :col

      t.timestamps null: false
    end
  end
end
