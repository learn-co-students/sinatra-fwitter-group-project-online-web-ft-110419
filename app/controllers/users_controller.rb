class UsersController < ApplicationController

    get '/' do 
        erb :"/users/login"
    end 

    
    get '/signup' do 
        if logged_in?
            redirect "/tweets"
        else 
            erb :"/users/create_user"
        end
    end 
    
    post '/signup' do 
        @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
       
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/login' do 
        if logged_in?
            redirect "/tweets"
        else 
            erb :"/users/login"
        end
    end 
    
    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to "/tweets"
		else
			redirect "/login"
		end
    end 

    get '/logout' do 
        session.clear
        redirect "/login"
    end

    get "/users/:id" do 
        @user = User.find_by(username: params(:username))
        erb :"/show/#{@user.id}"
    end 
   

end 
