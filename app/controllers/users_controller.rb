class UsersController < ApplicationController
  
  get "/signup" do
    if logged_in?
      redirect "/tweets"
    end
    erb :signup
  end
  
  post "/signup" do
    if params.values.any? { |value| value.blank? }
      redirect "/signup"
    elsif User.find_by(email: params[:email])
      redirect "/tweets"
    else
      user = User.create(params)
      session[:user_id] = user.id
    end
    redirect "/tweets"
  end
  
  get "/login" do
    if logged_in?
      redirect "/tweets"
    end
    erb :login
  end
  
  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    end
    redirect "/login"
  end
  
  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
  
  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end
  
end
