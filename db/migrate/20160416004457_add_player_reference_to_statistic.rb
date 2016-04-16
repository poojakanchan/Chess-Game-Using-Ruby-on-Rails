class AddPlayerReferenceToStatistic < ActiveRecord::Migration
  def change
    add_column :statistics,:player_id,:integer
  end
end
