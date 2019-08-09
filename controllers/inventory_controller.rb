require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )

get '/inventory' do
  @stock = Album.sort_all_by_artist_name()
  erb(:"inventory/index")
end
