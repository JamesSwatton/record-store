require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/album.rb' )
require_relative( './models/artist.rb' )
require_relative( './models/stock.rb' )
also_reload( '../models/*' )

get '/albums' do
  @albums = Album.all()
  erb(:"albums/index")
end

get '/albums/new' do
  erb(:"albums/new")
end

post '/albums' do
  # artist = Artist.new( {'name' => params['name']} )
  # artist.save()
  all_artists = Artist.all()
  artist_names = all_artists.map { |artist| artist.name }

  if artist_names.include?(param['name'])
      # use find_id_by_name method 
  end

  Album.new( {'title' => params['title'], 'artist_id' => artist.id, 'quantity' => params['quantity'] }).save()
  redirect to '/albums'
end
