class TweetsController < ApplicationController

    get '/tweets' do
        erb :'/tweets/show_tweets'
    end 

end
