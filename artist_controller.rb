require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/album.rb' )
require_relative( './models/artist.rb' )
require_relative( './models/stock.rb' )
also_reload( './models/*' )

get '/artists' do
  @artists = Artist.sort_all()
  erb(:"artists/index")
end
