class TweetsController < ApplicationController

  get '/homepage' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :'/tweets/homepage'
    else
      redirect '/failure'
    end
  end

  get '/tweets/new' do
    @current_user = User.find_by_id(session[:user_id])
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    @current_user = User.find_by_id(session[:user_id])
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  end

  post '/tweets' do
    @current_user = User.find_by_id(session[:user_id])
    @tweet = Tweet.create(content: params[:content])
    @current_user.tweets << @tweet
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    @current_user = User.find_by_id(session[:user_id])
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @tweet.user.id
      erb :'/tweets/edit'
    else
      redirect '/failure'
    end

  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params[:tweet])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect '/homepage'
  end

end
