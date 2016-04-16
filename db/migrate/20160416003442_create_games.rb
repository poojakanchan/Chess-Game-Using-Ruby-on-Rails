class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :category
      t.string :password
      t.boolean :public

      t.timestamps null: false
    end
  end
end
