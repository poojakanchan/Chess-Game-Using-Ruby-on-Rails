class RenameColumns < ActiveRecord::Migration
  def change
   rename_column :locations,:game,:game_id
   rename_column :locations,:player,:player_id
   add_column :player,:password,:string
  end
end
