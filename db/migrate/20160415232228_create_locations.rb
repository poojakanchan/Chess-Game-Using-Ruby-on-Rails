class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :row
      t.integer :col

      t.timestamps null: false
    end
  end
end
