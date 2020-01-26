class UsersController < ApplicationController
	get '/signup' do 
		if !is_logged_in?(session)
			erb :'users/signup'
		else 
			puts "You cannot see the signup page, you are already logged in."
			redirect '/tweets'
		end
	end

	post '/signup' do 
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			redirect '/tweets'
		else 
			@user.errors.each do |e|
				puts e 
			end
			redirect '/signup'
		end
	end

	get '/login' do 
		if !is_logged_in?(session)
			erb :'users/login'
		else 
			puts "You cannot see the login page, you are already logged in."
			redirect '/tweets'
		end
	end

	post '/login' do 
		user = User.find_by(username: params[:username]) 
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id 
			redirect '/tweets'
		else
			puts "Incorrect username or password"
			redirect '/login'
		end
	end

	get '/logout' do 
		if is_logged_in?(session)
			session.clear 
			redirect '/login'
		else 
			redirect '/'
		end
	end

	get '/users/:slug' do
		name = params[:slug].gsub("-", " ")
		puts "this is the user's name"
		puts name
		@user = User.find_by(username: name)
		erb :'users/show'
	end
end
