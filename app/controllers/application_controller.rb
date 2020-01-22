require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :views, 'app/views'
  end

  helpers do
		
		def current_user
			User.find(session[:user_id])
		end

    def logged_in?
			!!session[:user_id]
    end
	end
end
