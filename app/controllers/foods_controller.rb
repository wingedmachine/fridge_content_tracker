class FoodsController < ApplicationController
  get '/foods' do
    redirect '/login' unless logged_in?

    @foods = Food.all
    erb :'/foods/index'
  end

  post '/foods' do
    redirect '/login' unless logged_in?

    food = Food.new(name: params[:name], user_id: current_user.id, datetime_created: Time.now.to_i)
    if food.save
      redirect "/foods/#{food.id}"
    else
      # messages here
      redirect '/foods/new'
    end
  end

  get '/foods/new' do
    redirect '/login' unless logged_in?

    erb :'/foods/create'
  end

  get '/foods/:id' do
    redirect '/login' unless logged_in?

    @user == current_user
    @food = Food.find(params[:id])
    erb :'/foods/show'
  end

  put '/foods/:id' do
    redirect '/login' unless logged_in?
    redirect "/foods/#{params[:id]}" unless current_user.id == Food.find(params[:id]).user.id

    food = Food.find(params[:id])
    food.name = params[:name]
    if food.save
      redirect "/foods/#{params[:id]}"
    else
      #messages here
      redirect "/foods/:id/edit"
    end
  end

  delete '/foods/:id' do
    redirect '/login' unless logged_in?
    redirect "/foods/#{params[:id]}" unless current_user.id == Food.find(params[:id]).user.id

    Food.find(params[:id]).delete
    redirect "users/#{current_user.username}"
  end

  get '/foods/:id/edit' do
    redirect '/login' unless logged_in?
    redirect "/foods/#{params[:id]}" unless current_user.id == Food.find(params[:id]).user.id

    @food = Food.find(params[:id])
    erb :'/foods/edit'
  end
end
