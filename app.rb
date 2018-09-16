require 'sinatra'
require 'sinatra/activerecord'
require "./models/account"
require "./models/post"
# require "./models/profile"

enable :sessions

# set :database, {adapter: "postgresql", database: "netflixed"}


get '/' do 
    if session[:user_id]
        @user = Account.find(session[:user_id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @user_email = @user.email
        @user_bday = @user.birthday
        erb :index
    else
        erb :index
    end
end

get '/signin' do
    erb :signin
end

post '/signin' do
    @user = Account.find_by(username: params[:username])
    if @user && @user.password == params[:password]
        session[:user_id] = @user.id
        @user_username = @user.username
        @name_user = "#{@user.first_name} #{@user.last_name}"
        puts @name_user
        @user_email = @user.email
        @user_bday = @user.birthday.to_s
        redirect to("/user/#{session[:user_id]}/profile")
    else
        redirect to("/")
    end
end

get '/user/:id/profile' do
        @user = Account.find(params[:id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @user_email = @user.email
        @user_bday = @user.birthday
        @all_posts = Post.all
        @user_posts = []
                for post in @all_posts do
                    if post.account_id == @user.id
                        @user_posts.push(post)
                    end
                end
        erb :profile
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
    redirect to("/signin")
end

get '/user/:id/post' do
    if session[:user_id]
        @user = Account.find(session[:user_id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @user_email = @user.email
        @user_bday = @user.birthday
        erb :create_post
    else
        erb :signin
    end
end

post '/post' do
    if session[:user_id]
        @post = Post.create(account_id: session[:user_id], text_body: params[:text_body], post_title: params[:post_title])
        @user = Account.find_by(id: session[:user_id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @user_email = @user.email
        @user_bday = @user.birthday
        @textbody = @post.text_body
        @title = @post.post_title
        redirect to("/user/#{session[:user_id]}/profile")
    else
        erb :signin
    end
end

get '/user/:id/settings' do
    if session[:user_id]
        @user = Account.find(session[:user_id])
        @user_username = @user.username
        @user_name = "#{@user.first_name} #{@user.last_name}"
        @user_email = @user.email
        @user_bday = @user.birthday
        erb :settings
    else
        redirect to("/signin")
    end
end

delete '/delete/:id' do
    if session[:user_id]
        @user = Account.delete(params[:id])
        redirect to("/signin")
    else 
        redirect to("/settings")
    end
end
