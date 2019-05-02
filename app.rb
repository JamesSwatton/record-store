require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( './controllers/artists_controller.rb' )
require_relative( './controllers/albums_controller.rb' )
require_relative( './controllers/inventory_controller.rb' )

get '/' do
  erb(:"inventory/index")
end
