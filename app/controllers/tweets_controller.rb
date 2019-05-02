class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])
      erb :index
    else
      redirect '/login'
    end

  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])
      erb :'/tweets/new'
    else
      redirect "/login"
    end

  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end

  end

  post '/tweets' do
    if !params[:content].empty?
      @current_user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end

  end

  get '/tweets/:id/edit' do
    @current_user = User.find_by_id(session[:user_id])
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @tweet.user.id
      erb :'/tweets/edit'
    else
      redirect '/login'
    end

  end

  patch '/tweets/:id/edit' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update({content: params[:content]})
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end

  end

  delete '/tweets/:id/delete' do
    if Helpers.current_user(session) == Tweet.find_by_id(params[:id]).user
      @current_user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect "/users/#{@current_user.slug}"
    else
      redirect "/tweets/#{params[:id]}"
    end
  end

end
