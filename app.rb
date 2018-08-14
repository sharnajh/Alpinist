require 'sinatra'
require 'sinatra/activerecord'
require "./models/account"
require "./models/post"
# require "./models/profile"

enable :sessions

set :database, {adapter: "postgresql", database: "netflixed"}

get '/' do 
    erb :index
end

post '/' do
    @account = Account.create(
      username: params[:username],
      password: params[:password],
      name: params[:name],
      email: params[:email]
    )
end