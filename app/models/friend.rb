class Friend < ActiveRecord::Base
   belongs_to :player, :foreign_key => 'player1_id'
   belongs_to :player, :foreign_key => 'player2_id'
end
