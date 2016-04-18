class ChangeBinaryColumnToBytea < ActiveRecord::Migration
  def change
   change_column :players, :thumbnail,  :bytea 
  end
end
