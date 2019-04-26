require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/album.rb' )
require_relative( './models/artist.rb' )
require_relative( './models/stock.rb' )
also_reload( './models/*' )

get '/albums' do
  @albums = Album.all()
  erb(:"albums/index")
end

get '/albums/new' do
  erb(:"albums/new")
end

post '/albums' do
  all_artists = Artist.all()
  artist_names = all_artists.map { |artist| artist.name }

  if artist_names.include?(params['name'])
      # use find_id_by_name method
      artist_id = Artist.find_id_by_name(params['name'])
      Album.new( {'title' => params['title'], 'artist_id' => artist_id, 'quantity' => params['quantity'] }).save()
      redirect to '/albums'
  end

  artist = Artist.new( {'name' => params['name']} )
  artist.save()
  Album.new( {'title' => params['title'], 'artist_id' => artist.id, 'quantity' => params['quantity'] }).save()
  redirect to '/albums'
end
