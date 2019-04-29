require_relative('../models/artist')
require_relative('../models/album')
require_relative('../models/stock')

# Stock.delete_all()
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

artist3 = Artist.new({
  "name" => "ABBA"
  })

artist3.save()

artist4 = Artist.new({
  "name" => "Blur"
  })

artist4.save()

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
  "quantity" => 50
  })

album3.save()

album4 = Album.new({
  "title" => "Gold",
  "artist_id" => artist3.id,
  "quantity" => 70
  })

album4.save()

p artist1.albums().count
# p Album.all().count
# p Album.find(26)
p album1.artist().name
# album1.quantity = 5
# album1.update()

# p Artist.find_id_by_name('Can')

# p Artist.sort_all()

# p Album.sort_all_by_artist_name()

# p Album.all()

p Artist.first_char_from_names()

# p Artist.filter_by_char('B')

# p Album.exists?(album1.title)

# Album.delete_all_by_artist(artist1.id)

band = "Rolling Stones The"
p Artist.swap_the(band)
