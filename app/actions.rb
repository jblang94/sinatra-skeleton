# Enables cookies in Sinatra
enable :sessions

helpers do

  # returns the instance of the current user if the session has a logged in user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

#############################
  ####  HOME PAGE #####
#############################

# Homepage (Root path)
get '/' do
  erb :index
end

#############################
  ####  SONG WALL #####
#############################

# Bring users to a list of all songs
# Orders songs by their upvote counts in DESCENDING order
get '/songs' do
  @songs = Song.order_by_upvote_count
  erb :'songs/index'
end

# Bring users to a form in which they can add songs to the song wall
get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

# Show the detail of a song
get '/songs/:id' do
  @song = Song.find(params[:id])
  erb :'songs/details'
end

# POST = creation, here we are creating a new song from the form
# saving it, and then REDIRECTING to /songs
post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )

  @song.user = current_user

  if @song.save
      redirect '/songs'
  else
    erb :'songs/new'
  end
end

# Technically should be a post, but we are not using jQuery yet
get '/upvote/:song_id' do
  @upvote = Upvote.new(user: current_user, song: Song.find(params[:song_id]))

  if @upvote.save
    session[:flash] = "You upvoted!"
  end

  redirect '/songs'

end

#############################
     ####  USER #####
#############################

# Presents the create account page
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

# Creates the user in the database, as long as the fields are satisfied
# Upon successful save, the user is brought back to the home page
# otherwise, the form is shown again with the errors
post '/users' do
  @user = User.new(
    email: params[:email],
    password: params[:password])

  if @user.save
    redirect '/'
  else
    erb :'users/new'
  end
end

#############################
     ####  SESSION #####
#############################

# Present the login form
get '/sessions/new' do
  erb :'sessions/new'
end

# Redirect the user to the home page if successful
# Otherwise, show the login form with an invalid login error
post '/sessions' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:flash] = "Welcome #{@user.email}!"
    session[:user_id] = @user.id
    redirect '/'
  else
    session[:flash] = "Invalid login!"
    erb :'sessions/new'
  end
end

# Logs a user out
get '/sessions/logout' do
  session.delete(:user_id)
  redirect '/'
end