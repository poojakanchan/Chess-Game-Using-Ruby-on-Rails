require 'pusher'

class ChatController < ApplicationController
  def message 
 
   
   
  @timestamp = Time.now().strftime("%d/%m/%Y %H:%M")
  @msg = {
    "name" => current_user.name,
     "message" => params[:message], 
     "timestamp" => @timestamp
   }
     pusher_client = Pusher::Client.new(
    app_id: ENV['PUSHER_APP_ID'],
    key: ENV['PUSHER_KEY'],
    secret: ENV['PUSHER_SECRET'],
    encrypted: true
  )
     logger.error params
     
  pusher_client.trigger('public-chat', 'message-sent', {
    name: current_user.name,
    message: params[:message],
    timestamp: @timestamp
  })

  #Pusher.trigger('test_channel', 'my_event', {
   #   message: 'hello world'
   # })
    
  #respond_to :js
 	  render :json => @msg, status: :ok
		
  end
 
end


