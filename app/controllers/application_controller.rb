require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
  
  	get '/' do 
  		puts "This is the user's id"
  		puts session[:user_id]
  		if is_logged_in?(session)
  			@user = current_user(session)
  			erb :'homepage'
  		else
  			erb :'homepage'
  		end
  	end

	helpers do
		def is_logged_in?(hash)
			!!current_user(hash)
		end

		def current_user(hash)
			if hash[:user_id]
				User.find_by_id(hash[:user_id])
			else
				false
			end
		end
	end
end

