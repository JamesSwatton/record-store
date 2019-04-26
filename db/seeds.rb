require_relative('../models/artist')
require_relative('../models/album')
require_relative('../models/stock')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "The Beatles"
  })

artist1.save()

artist2 = Artist.new({
  "name" => "Can"
  })

artist2.save()

album1 = Album.new({
  "title" => "Abbey Road",
  "artist_id" => artist1.id,
  "quantity" => 10
  })

album1.save()

album2 = Album.new({
  "title" => "Revolver",
  "artist_id" => artist1.id,
  "quantity" => 25
  })

album2.save()

album3 = Album.new({
  "title" => "Ege Bamyasi",
  "artist_id" => artist2.id,
  "quantity" => 25
  })

album3.save()

p artist1.albums().count
