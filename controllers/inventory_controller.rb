require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )

get '/inventory' do
  @stock = Album.sort_all_by_artist_name()
  @stock_levels = ["HIGH", "LOW"]
  @total = Album.all_stock_total()
  erb(:"inventory/index")
end

get '/inventory/sort/:level' do
  @stock = Album.sort_all_by_stock_level(params[:level].upcase)
  @stock_levels = ["HIGH", "LOW"]
  @total = Album.all_stock_total()
  erb(:'inventory/index')
end
