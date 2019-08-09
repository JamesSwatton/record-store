require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/album.rb' )
require_relative( '../models/artist.rb' )
also_reload( '../models/*' )

get '/albums' do
  @first_char_from_titles = Album.first_char_from_titles()
  # binding.pry
  @albums = Album.sort_all()
  @recently_added_album = Album.all.pop
  erb(:"albums/index")
end

get '/albums/new' do
  @artists = Artist.sort_all()
  erb(:"albums/new")
end

post '/albums/new' do
  Album.new(params).save()
  redirect to "/albums"
end

get '/albums/filter/:char' do
  @first_char_from_titles = Album.first_char_from_titles()
  @albums = Album.filter_by_char(params[:char].upcase)
  @recently_added_album = Album.all.pop
  erb(:'albums/index')
end

get '/albums/:id' do
  @album = Album.find(params['id'])
  erb(:"albums/show")
end

get '/albums/:id/new' do
  @artist = Artist.find(params['id'])
  erb(:"albums/id_new")
end

post '/albums/:id/new' do
  album_title = params['title']

  if Album.exists?(album_title)
    redirect to "/artists/#{params['id']}"
  end

  Album.new( params ).save()
  redirect to "/artists/#{params['id']}"
end

get '/albums/:id/edit' do
  @artists = Artist.all()
  @album = Album.find(params['id'])
  erb(:"albums/edit")
end

post '/albums/:id/edit' do
  album = Album.new( params )

  album.update
  redirect to "/albums"
end

post '/albums/:id/delete' do
  Album.delete(params['id'])
  redirect to '/albums'
end
