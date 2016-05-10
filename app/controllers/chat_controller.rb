require 'pusher'

class ChatController < ApplicationController
  def message    
    logger.error params

    pusher_client.trigger('public-chat', 'message-sent', get_message )

 	  render :json => @msg, status: :ok
  end

  private

  def get_message 
    @message ||= {
      name: current_user.name,
      message: params[:message],
      timestamp: Time.now().strftime("%d/%m/%Y %H:%M")
    }
  end
 
  def pusher_client
    @pusher_client ||= Pusher::Client.new(
      app_id: ENV['PUSHER_APP_ID'],
      key: ENV['PUSHER_KEY'],
      secret: ENV['PUSHER_SECRET'],
      encrypted: true
    )
  end

end


