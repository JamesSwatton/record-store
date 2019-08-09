require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "The Beatles"
  })
artist2 = Artist.new({
  "name" => "Can"
  })
artist3 = Artist.new({
  "name" => "ABBA"
  })
artist4 = Artist.new({
  "name" => "Blur"
  })
artist5 = Artist.new({
  "name" => "The Rolling Stones"
  })
artist6 = Artist.new({
  "name" => "The Pink Floyd"
  })

artist1.save()
artist2.save()
artist3.save()
artist4.save()
artist5.save()
artist6.save()

album1 = Album.new({
  "title" => "Abbey Road",
  "artist_id" => artist1.id,
  "quantity" => 10,
  "price" => 15.99
  })
album2 = Album.new({
  "title" => "Revolver",
  "artist_id" => artist1.id,
  "quantity" => 25,
  "price" => 14.99
  })
album3 = Album.new({
  "title" => "Ege Bamyasi",
  "artist_id" => artist2.id,
  "quantity" => 50,
  "price" => 14.99
  })
album4 = Album.new({
  "title" => "Gold",
  "artist_id" => artist3.id,
  "quantity" => 70,
  "price" => 8.99
  })

album1.save()
album2.save()
album3.save()
album4.save()

# album4.price = 10.50
# album4.update()
# p album4.price
