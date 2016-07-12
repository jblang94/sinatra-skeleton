# Homepage (Root path)
get '/' do
  erb :index
end

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