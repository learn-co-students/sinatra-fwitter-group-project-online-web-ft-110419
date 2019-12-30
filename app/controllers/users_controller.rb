class UsersController < ApplicationController


  get '/signup' do
    # if logged_in?
    #     redirect '/tweets'
    # else 
         erb :'users/signup'
    # end 
  end 

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
    else 
        @user = User.new(
            :username => params["username"],
            :email => params["email"],
            :password_digest => params["password"])
        session[:user_id] = @user.id
        @user.save
        # binding.pry
        redirect '/tweets'
    end 
  end 

end
