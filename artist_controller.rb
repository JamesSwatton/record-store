require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/album.rb' )
require_relative( './models/artist.rb' )
require_relative( './models/stock.rb' )
also_reload( './models/*' )

get '/artists' do
  @first_char_from_names = Artist.first_char_from_names()
  @artists = Artist.sort_all()
  @recently_added_artist = Artist.all.pop
  erb(:"artists/index")
end

get '/artists/new' do
  erb(:"artists/new")
end

post '/artists' do
  if Artist.all_names.include?(swap_the(params['name']))
    redirect to '/artists/new'
  end
  Artist.new(params).save()
  redirect to '/artists'
end

get '/artists/:id' do
  @artist = Artist.find(params['id'])
  erb(:"artists/show")
end

post '/artists/:id/delete' do
  Artist.delete(params['id'])
  redirect to '/artists'
end


def swap_the(string)
  if string.start_with?("The") || string.end_with?("The")
    string = string.split.reverse.join(" ")
    return string
  end
  return string
end
