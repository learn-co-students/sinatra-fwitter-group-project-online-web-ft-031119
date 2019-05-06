class UsersController < ApplicationController

  get '/' do
    @current_user = User.find_by_id(session[:user_id])
    erb :'/home'
  end

  get '/login' do
    @current_user = User.find_by_id(params[:user_id])
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end
    erb :'/users/login'
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end
    erb :'/users/signup'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @current_user = Helpers.current_user(session)
    erb :'/users/user_show_page'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
