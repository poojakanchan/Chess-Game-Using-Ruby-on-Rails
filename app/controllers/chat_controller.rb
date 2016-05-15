require 'pusher'

class ChatController < ApplicationController
  # send message to pusher
  def message    
    logger.error params

    pusher_client.trigger('public-chat', 'message-sent', get_message )

 	  render :json => @msg, status: :ok
  end

  private

 # create a message
  def get_message 
    @message ||= {
      name: current_user.email,
      message: params[:message],
      timestamp: Time.now().strftime("%d/%m/%Y %H:%M")
    }
  end
 
 # get pusher client object
  def pusher_client
    @pusher_client ||= Pusher::Client.new(
      app_id: ENV['PUSHER_APP_ID'],
      key: ENV['PUSHER_KEY'],
      secret: ENV['PUSHER_SECRET'],
      encrypted: true
    )
  end

end


