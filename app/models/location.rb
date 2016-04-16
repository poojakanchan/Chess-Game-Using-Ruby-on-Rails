class Location < ActiveRecord::Base
   belongs_to :game
   belongs_to :piece
   belongs_to :player
end
