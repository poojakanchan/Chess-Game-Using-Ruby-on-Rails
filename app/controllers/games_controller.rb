class GamesController < ApplicationController
  

  # GET /games/1
  # GET /games/1.json
  def show
    if(params.has_key?(:user) && params.has_key?(:game_id))
    @user =  params[:user]
    @game_id = params[:game_id]
    @game = Game.find(@game_id)
    @game.user_black_id = @user
    @game.save

    end
  end

  def join


   end 

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  # POST /games.json
  def create
     pusher_client = Pusher::Client.new(
    app_id: ENV['PUSHER_APP_ID'],
    key: ENV['PUSHER_KEY'],
    secret: ENV['PUSHER_SECRET'],
    encrypted: true
  )
    @game = Game.new
    @game.user_white_id = current_user.id.to_i
    @game.save
    id = "game" + @game.id.to_s

    pusher_client.trigger(id, 'create', {
    name: current_user.name
  })

    @msg = {
       "redirect" => true,
       "redirectURL" => '/games/' + @game.id.to_s
    }
     render :json => @msg, status: :ok
    
  end 

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



 def move 
 
   
    pusher_client = Pusher::Client.new(
    app_id: ENV['PUSHER_APP_ID'],
    key: ENV['PUSHER_KEY'],
    secret: ENV['PUSHER_SECRET'],
    encrypted: true
  )
 
  pusher_client.trigger('chess', 'move', {
    source: params[:source],
    target: params[:target],
    piece: params[:piece],
    newposition: params[:newposition]
    #timestamp: @timestamp
  })

  #Pusher.trigger('test_channel', 'my_event', {
   #   message: 'hello world'
   # })
    
  respond_to :js
    #render :json , status: :ok
    
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end
end