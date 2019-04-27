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

# stock1 = Stock.new({
#   "artist_id" => album1.artist_id,
#   "album_id" => album1.id,
#   "stock_level" => album1.quantity
#   })
#
# stock1.save()
#
# stock2 = Stock.new({
#   "artist_id" => album2.artist_id,
#   "album_id" => album2.id,
#   "stock_level" => album2.quantity
#   })
#
# stock2.save()
#
# stock3 = Stock.new({
#   "artist_id" => album3.artist_id,
#   "album_id" => album3.id,
#   "stock_level" => album3.quantity
#   })
#
# stock3.save()


p artist1.albums().count
p Album.all().count
# p Album.find(26)
p album1.artist().name
# album1.quantity = 5
# album1.update()

# p Artist.find_id_by_name('Can')

# p Artist.sort_all()
