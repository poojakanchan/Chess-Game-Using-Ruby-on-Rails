require 'pusher'

class ChatController < ApplicationController
  def message 
 
   
    pusher_client = Pusher::Client.new(
    app_id: ENV['PUSHER_APP_ID'],
    key: ENV['PUSHER_KEY'],
    secret: ENV['PUSHER_SECRET'],
    encrypted: true
  )

  pusher_client.trigger('public-chat', 'message-sent', {
    name: current_user.email,
    message: params[:message],
    timestamp: Time.now()
  })
  #Pusher.trigger('test_channel', 'my_event', {
   #   message: 'hello world'
   # })
    
  respond_to :js
 	#  render json, status: :ok
		
  end

end
