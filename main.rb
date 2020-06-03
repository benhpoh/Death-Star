require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'

require_relative 'models/planets'
require_relative 'models/users'

enable :sessions

def logged_in?
  !!session[:user_name]
end

# before '/*' do
#   if !logged_in?
#     redirect "/login" unless params[:splat] == 'login'
#   end
# end

get '/' do
  redirect "/login" unless logged_in?
  planets = list_all_planets
  erb :index, locals: {planets: planets}
end

get '/login' do
  erb :login
end

post '/login' do
  user = list_user_by_name(params["name"])

  if user && BCrypt::Password.new(user["digested_password"]) == params["password"]
    session["user_name"] = user["name"]
    redirect "/"
  else
    erb :login
  end
end

delete '/logout' do
  session["user_name"] = nil
  redirect "/"
end

get "/planet/new" do
  redirect "/login" unless logged_in?
  erb :new
end

post "/planet/new" do
  create_planet(params["name"], params["distance"], params["moon_count"], params["image_url"])
  redirect "/"
end

post "/planet/new/random" do
  create_random_planet()
  redirect "/"
end

get "/planet/update" do
  redirect "/login" unless logged_in?
  planets = list_all_planets
  erb :preedit, locals: {planets: planets}
end

get "/planet/:id" do
  redirect "/login" unless logged_in?
  planet = list_planet_by_id(params["id"])
  erb :planet, locals: {planet: planet}
end

delete "/planet" do
  delete_planet_by_id(params["id"])
  erb :delete, locals: {name: params["name"]}
end

get "/planet/update/:id" do
  redirect "/login" unless logged_in?
  planet = list_planet_by_id(params["id"])
  erb :edit, locals: {planet: planet}
end

patch "/planet" do
  update_planet_by_id(params["id"], params["name"], params["distance"], params["moon_count"], params["image_url"])
  redirect "/"
end

