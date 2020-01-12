class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
           @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
      if logged_in?
          @tweet = Tweet.find_by(id: params[:id])
          erb :'tweets/show_tweet'
      else
        redirect '/login'
      end

    end

    delete '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.delete
            end
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

end
