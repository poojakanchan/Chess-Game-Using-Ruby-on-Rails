class Game < ActiveRecord::Base
    belongs_to :user, :foreign_key => 'user_white_id'
    belongs_to :user, :foreign_key => 'user_black_id'

end
