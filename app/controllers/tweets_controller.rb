class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if logged_in?(session) && tweet.user == current_user
      tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end


end
