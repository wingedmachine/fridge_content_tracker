class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/users'
    end
  end

  post '/signup' do
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/users'
      else
        # messages here
        redirect '/signup'
      end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect '/users'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/users'
    else
      # messges here
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users' do
    erb :'users/index'
  end

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'users/show'
  end
end
