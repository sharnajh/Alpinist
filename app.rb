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

get '/signin' do
    erb :signin
end

post '/signin' do
    @user = Account.find_by(username: params[:username])
    if @user && @user.password == params[:password]
        session[:user_id] = @user.id
        @user_username = @user.username
    else
        redirect "/"
    end
    erb :index
end

get '/user/:id' do
    if session[:user_id]
        @user = Account.find(params[:id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        erb :profile
    else
        erb :signin
    end
end

get "/signout" do
    session[:user_id] = nil
    redirect "/"
  end

get '/signup' do
    erb :signup
end

post '/signup' do
    @user = Account.create(
      username: params[:username],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      birthday: params[:birthday],
      email: params[:email]
    )
    redirect '/'
end

get '/post' do
    if session[:user_id]
        erb :create_post
    else
        erb :signin
    end
end

post '/post' do
    if session[:user_id]
        @post = Post.create(account_id: session[:user_id], description: params[:text_body])
        @user = Account.find_by(id: session[:user_id])
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @textbody = @post.description
    else
        erb :signin
    end
end

get '/settings' do
    erb :settings
end

delete '/delete/:id' do
    if session[:user_id]
        @user = Account.delete(params[:id])
        redirect to("/")
    else 
        redirect to("/settings")
    end
end