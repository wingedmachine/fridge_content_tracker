class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/foods'
    end
  end

  post '/signup' do
      user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect to '/foods'
      else
        messages = user.errors.messages
        flash[:message] = messages.map { |k,v| "#{k} #{v.first}" }.to_sentence
        redirect '/signup'
      end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect '/foods'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/foods'
    else
      flash[:message] = "Incorrect username or password"
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users' do
    redirect '/login' unless logged_in?

    @users = User.all.select { |user| user.foods.size > 0 }
    erb :'/users/index'
  end

  get '/users/:username' do
    redirect '/login' unless logged_in?

    @user = User.find_by(username: params[:username])
    erb :'/users/show'
  end
end
