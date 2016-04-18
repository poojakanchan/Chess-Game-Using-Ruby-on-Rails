class ChnagePlayerToUser < ActiveRecord::Migration
  def change
  rename_column :statistics,:player_id,:user_id
  rename_column :friends,:player1_id,:user1_id
  rename_column :friends,:player2_id,:user2_id
  rename_column :games,:player_white_id,:user_white_id
  rename_column :games,:player_black_id,:user_black_id
  rename_column :locations,:player_id,:user_id

  end
end
