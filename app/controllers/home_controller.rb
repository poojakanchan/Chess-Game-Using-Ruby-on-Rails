class HomeController < ApplicationController
   require 'pusher'

Pusher.app_id = '198965'
Pusher.key = '263edcd8170410acaa6b'
Pusher.secret = 'f79de19f07eb7cd9140c'
Pusher.logger = Rails.logger
Pusher.encrypted = true
   def index
      if(params.has_key?(:first_name) && params.has_key?(:last_name))
         @full_name = params[:first_name] + params[:last_name];      
      end
      
      if current_user && current_user.statistic

         params[:statistics] = current_user.statistic

      end
      
        @king = Piece.find_by_name("black_king")
        #@image_url =  @king.image
   end

  def sample
    @controller_message = "Hello"
  end
end
