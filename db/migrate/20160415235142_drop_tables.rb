class DropTables < ActiveRecord::Migration
  def change
    drop_table :chess_games
    drop_table :chess_pieces
    drop_table :piece_locations
    drop_table :players
    drop_table :statistics
    drop_table :friends
  end
end
