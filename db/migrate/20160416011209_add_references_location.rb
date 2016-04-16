class AddReferencesLocation < ActiveRecord::Migration
  def change
   add_column :locations,:player,:integer
   add_column :locations,:game,:integer
  end
end
