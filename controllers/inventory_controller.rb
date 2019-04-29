require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
require_relative( '../models/stock.rb' )
also_reload( '../models/*' )

get '/inventory' do
  @stock = Album.sort_all_by_artist_name()
  erb(:"inventory/index")
end


def swap_the(string)
  if string.start_with?("The") || string.end_with?("The")
    string = string.split.reverse.join(" ")
    return string
  end
  return string
end
