class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :statistic
  has_one :facebook_oauth_setting

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    after_create do |user|
      @statistics = Statistic.create(wins:0,loses:0)
      @statistics.save   
      user.statistic = @statistics
    end
end
