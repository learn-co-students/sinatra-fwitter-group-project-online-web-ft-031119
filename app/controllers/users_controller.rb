class UsersController < ApplicationController

  get '/' do
    @current_user = User.find_by_id(session[:user_id])
    erb :'/index'
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  get '/failure' do
    erb :'/users/failure'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/signup' do
    user = User.new(username: params[:username], password: params[:password])

    if user.save
      redirect '/login'
    else
      redirect '/failure'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/homepage'
    else
      redirect '/failure'
    end
  end

end
