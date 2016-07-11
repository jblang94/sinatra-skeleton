# Homepage (Root path)
get '/' do
  erb :index
end

# Bring users to a list of all songs
get '/songs' do
  erb :'songs/index'
end
