class GamesController < ApplicationController
  

  # GET /games/1
  # GET /games/1.json
  def show
    if(params.has_key?(:user) && params.has_key?(:color))
      @user =  params[:user]
      @color = params[:color]
      @game_id = params[:game_id]
      puts @game_id
      if(params[:color] == "black")
           @game = Game.find(@game_id)
          @game.user_black_id = @user
          @game.save
       end
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
        "color"  => "white",
        "user_id" => current_user.id,
        "game_id" => @game.id,
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
 
  if(params.has_key?(:status))
          @game = Game.find(params[:game_id])
       if(params[:status] == "checkmate") 
            if(@game.user_white_id == current_user.id)
                @oponent_id = @game.user_black_id
             else
              @oponent_id = @game.user_white_id
            end
            
            @stat = current_user.statistic
            @oponent_stat = User.find(@oponent_id).statistic
            if(params[:winner] == "yes")               
                @stat.wins = @stat.wins + 1
                @oponent_stat.loses = @oponent_stat.loses +1
            else
                @stat.loses = @stat.loses + 1
                @oponent_stat.wins = @oponent_stat.wins +1
            end
            @stat.save
            @oponent_stat.save
            @game.destroy
       elsif (params[:status] == "draw")
          @game.destroy            
        end
        
    end 

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