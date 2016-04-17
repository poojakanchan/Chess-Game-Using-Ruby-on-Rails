class HomeController < ApplicationController
   def hello
      if(params.has_key?(:first_name) && params.has_key?(:last_name))
         @full_name = params[:first_name] + params[:last_name];      
      end
   end

  def sample
    @controller_message = "Hello"
  end
end
