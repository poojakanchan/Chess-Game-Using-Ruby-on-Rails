class AddFenStringToGames < ActiveRecord::Migration
  def change
    add_column :games, :fen_string, :string, :default => "start"
  end
end
