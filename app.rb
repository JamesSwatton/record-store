require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( './controllers/artists_controller.rb' )
require_relative( './controllers/albums_controller.rb' )
require_relative( './controllers/inventory_controller.rb' )

get '/' do
  @stock = Album.sort_all_by_artist_name()
  @stock_levels = ["HIGH", "LOW"]
  @total = Album.all_stock_total()
  erb(:"inventory/index")
end
