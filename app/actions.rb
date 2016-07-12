enable :sessions

# Homepage (Root path)
get '/' do
  erb :index
end

###### SONG WALL #########

# Bring users to a list of all songs
get '/songs' do
  @songs = Song.all
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

  if @song.save
      redirect '/songs'
  else
    erb :'songs/new'
  end
end

####### USERS ###############

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

##### SESSION ############
