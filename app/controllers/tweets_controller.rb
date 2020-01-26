class TweetsController < ApplicationController
	
	get '/tweets/new' do 
		if is_logged_in?(session)
			erb :'tweets/new'
		else 
			puts "You cannot create a tweet, you are not logged in."
			redirect '/login'
		end
	end

	get '/tweets' do 
	  	if is_logged_in?(session)
	  		@user = current_user(session)
  			@tweets = Tweet.all
  			erb :'tweets/index'
  		else
  			puts "You are not logged in"
  			redirect '/login'
  		end
  	end


	post '/tweets' do 
		if !params[:content].empty?
			@tweet = Tweet.new(content: params[:content])
			@tweet.user = current_user(session)
			if @tweet.save
				erb :'tweets/show'
			else
				@tweet.errors.each do |e|
					puts e 
				end
			end
		else
			puts "You cannot post a blank tweet."
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id' do 
		@tweet = Tweet.find_by_id(params[:id])
		if @tweet && is_logged_in?(session)
			erb :'tweets/show'
		else 
			puts "There is no tweet with that ID or you are not logged in."
			redirect '/login'
		end
	end

	patch '/tweets/:id' do 
		@tweet = Tweet.find_by_id(params[:id])
		if !params[:content].empty?
			@tweet.update(content: params[:content])
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else 
			redirect "/tweets/#{@tweet.id}/edit"
		end
	end

	delete '/tweets/:id' do 
		@tweet = Tweet.find_by_id(params[:id])
		if @tweet.user == current_user(session)
			@tweet.destroy
			redirect "/tweets"
		else 
			redirect "/tweets/#{@tweet.id}"
		end
	end

	get '/tweets/:id/edit' do
		@tweet = Tweet.find_by_id(params[:id])
		if @tweet && @tweet.user == current_user(session)
			erb :'tweets/edit'
		else 
			puts "This is not your tweet, you cannot edit it."
			redirect '/login'
		end
	end
end
