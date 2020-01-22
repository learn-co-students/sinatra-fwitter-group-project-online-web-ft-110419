class TweetsController < ApplicationController

    get "/tweets" do 
        @tweets = Tweet.all
        if logged_in?
            erb :"/tweets/tweets"
        else 
            redirect "/login"
        end
    end
     
# create
    get "/tweets/new" do 
        if logged_in?
            erb :"/tweets/new"
        else  
            redirect '/login'
        end 
    end 

    post "/tweets" do 
        @tweet = Tweet.new(content: params[:content])
        
          if @tweet.content.empty?
            redirect "/tweets/new"
          else 
            @tweet.user_id = current_user.id
             @tweet.save
             redirect "/tweets/#{@tweet.id}"
          end 
    end 
    
    # read
    get "/tweets/:id" do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show_tweet"
        else 
            redirect "/login"
        end
    end 

    # Update
    get "/tweets/:id/edit" do
        # if tweet.user_id doesn't match current_user.id
        # redirect to /tweets
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && current_user.id == @tweet.user_id 
            erb :"/tweets/edit_tweet"
        else 
            redirect "/login"
        end 
    end 

    patch "/tweets/:id" do 
        @tweet = Tweet.find_by(user_id: current_user[:id])
        if current_user.id == @tweet.user_id && !params[:content].empty?
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end 
    
    delete "/tweets" do 
        @tweet = Tweet.find_by(user_id: current_user.id)
        if logged_in?
            @tweet.delete
            redirect "/tweets"
        end 
    end 

end
