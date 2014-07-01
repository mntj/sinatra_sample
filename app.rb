require 'bundler'
Bundler.require

require_relative 'models/user'
require_relative 'models/message'
require_relative 'config.rb'

# Display all users
get '/' do
  @users = User.all
  erb :index
end

# User creation page
get '/users/new' do
  erb :'users/new'
end

# Create a new user
post '/users' do
  username = params[:username]
  new_user = User.create({username: username})
  redirect "/users/#{new_user.id}"
end

# Show a user
get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/show'
end

# Show user edit page
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'users/edit'
end

# Update user
put '/users/:id' do
  @user = User.find(params[:id])
  @user.username = params[:username]
  @user.save
  redirect "/users/#{@user.id}"
end

# Message creation page
get '/users/:id/messages/new' do
  @user = User.find(params[:id])
  erb :'messages/new'
end

# Create new message
post '/users/:id/messages' do
  user = User.find(params[:id])
  message = params[:message]
  new_message = Message.create({message: message})
  user.messages << new_message
  redirect "/users/#{params[:id]}"
end

# Delete message
delete '/users/:user_id/messages/:id' do
  user_id = params[:user_id]
  Message.delete(params[:id])
  redirect "/users/#{user_id}"
end
