class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :wins
      t.integer :loses

      t.timestamps null: false
    end
  end
end
