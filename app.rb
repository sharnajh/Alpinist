require 'sinatra'
require 'sinatra/activerecord'
require "./models/account"
require "./models/post"
# require "./models/profile"

enable :sessions

set :database, {adapter: "postgresql", database: "netflixed"}


get '/' do 
    "Hello World"
end