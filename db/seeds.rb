require_relative('../models/artist')
require_relative('../models/album')
require_relative('../models/stock')

Artist.delete_all()
Album.delete_all()

artist1 = Artist.new({
  "name" => "The Beatles"
  })

artist1.save()

artist2 = Artist.new({
  "name" => "Can"
  })

artist2.save()
