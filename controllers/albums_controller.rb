require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
require_relative( '../models/stock.rb' )
also_reload( '../models/*' )

get '/albums' do
  @albums = Album.all()
  erb(:"albums/index")
end

get '/albums/:id/new' do
  @artist = Artist.find(params['id'])
  erb(:"albums/new")
end

post '/albums' do
  album_title = params['title']

  if Album.exists?(album_title)
    redirect to '/albums'
  end

  Album.new( params ).save()
  redirect to '/artists'
end

get '/albums/:id/edit' do
  @album = Album.find(params['id'])
  erb(:"albums/edit")
end

post '/albums/:id' do
  album = Album.new( params )
  # binding.pry

  album.update
  redirect to "/albums"
end



def swap_the(string)
  if string.start_with?("The") || string.end_with?("The")
    string = string.split.reverse.join(" ")
    return string
  end
  return string
end
