class Game < ActiveRecord::Base
    belongs_to :player, :foreign_key => 'player_white_id'
    belongs_to :player, :foreign_key => 'player_black_id'

end
