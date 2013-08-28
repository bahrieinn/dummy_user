enable :sessions


# get '/foo' do
#   session.inspect
# end

# ##### GET ############

get '/' do
  @error = session[:error]
  @user = session[:user]
  if @user
    erb :show
  else
    erb :index
  end
end

get '/user/new' do

  erb :new
end

get '/user/logout' do
  session.clear
  redirect ("/")
end

get '/user/:id' do
  @user = User.find(params[:id])
  session[:user] = @user
  erb :show
end


##### POST ############
post '/user' do
  #if password correct
  @user_input = params[:user]

  @user = User.where(email: @user_input[:email]).first
  if @user && @user_input[:password] == @user.password
    redirect("/user/#{@user.id}")
  else
    session[:error] = "Try again"
    redirect ("/")
  end

  # else
  #   session[:error]  = "Can't find user"
  # end
end

post '/user/new' do
  @user = User.create!(params[:user])
  redirect ("/user/#{@user.id}")
end

