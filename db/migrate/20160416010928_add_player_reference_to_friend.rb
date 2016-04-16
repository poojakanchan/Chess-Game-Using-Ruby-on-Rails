class AddPlayerReferenceToFriend < ActiveRecord::Migration
  def change
    add_column :friends,:player1_id,:integer
    add_column :friends,:player2_id,:integer

  end
end
