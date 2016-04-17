class Player < ActiveRecord::Base
   validates :username, presence: true,
             length: { minimum: 4 }
   validates :password, presence: true,
             length: { minimum: 8 } 
   validates_confirmation_of :password
    has_one :statistic
end
