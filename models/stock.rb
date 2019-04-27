class Stock
  #
  # attr_reader :id, :artist_id, :album_id, :stock_level
  #
  # def initialize(options)
  #   # @id = options['id'].to_i if options['id']
  #   @artist_id = options['artist_id'].to_i
  #   @album_id = options['album_id'].to_i
  #   @stock_level = options['stock_level'].to_i
  # end
  #
  # def save()
  #   sql = "INSERT INTO inventory (artist_id, album_id, stock_level)
  #         VALUES ($1,$2,$3)"
  #   values = [@artist_id, @album_id, stock_level()]
  #   SqlRunner.run(sql, values)
  # end
  #
  # def stock_level()
  #   if @stock_level >= 30
  #     return "HIGH"
  #   elsif @stock_level < 30 && @stock_level > 10
  #     return "MED"
  #   else
  #     return "LOW"
  #   end
  # end
  #
  # def self.delete_all()
  #   sql = "DELETE FROM inventory"
  #   SqlRunner.run(sql)
  # end
  # def self.all()
  #   sql = "SELECT title, name, quantity
  #         FROM albums
  #         JOIN artists
  #         ON artists.id = albums.artist_id;"
  # end

end
