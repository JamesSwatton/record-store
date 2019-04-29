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

get '/albums/new' do
  erb(:"albums/new")
end

post '/albums' do
  album_title = params['title']
  artist_name = swap_the(params['name'])

  if Album.exists?(album_title)
    redirect to '/albums'
  end

  if Artist.exists?(artist_name)
      # use find_id_by_name method
      artist_id = Artist.find_id_by_name(artist_name)
      Album.new( {'title' => params['title'], 'artist_id' => artist_id, 'quantity' => params['quantity'] }).save()
      redirect to '/albums'
  end

  artist = Artist.new( {'name' => artist_name} )
  artist.save()
  Album.new( {'title' => params['title'], 'artist_id' => artist.id, 'quantity' => params['quantity'] }).save()
  redirect to '/albums'
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
