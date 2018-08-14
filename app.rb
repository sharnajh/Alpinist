require 'sinatra'
require 'sinatra/activerecord'


set :database, {adapter: "postgresql", database: "netflixed"}

get '/' do 
    erb :index
end