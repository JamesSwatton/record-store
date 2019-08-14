require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_reader :id, :title, :artist_id
  attr_accessor :quantity, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @quantity = options['quantity'].to_i
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO albums (title, artist_id, quantity, price)
          VALUES ($1,$2,$3,$4)
          RETURNING id;"
    values = [@title, @artist_id, @quantity, @price]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def update()
    sql = "UPDATE albums
          SET (title, artist_id, quantity, price) = ($1,$2,$3,$4)
          WHERE id = $5"
    price = '%.2f' % @price
    values = [@title, @artist_id, @quantity, price, @id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists
          WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    return Artist.new(results[0])
  end

  def stock_level()
    if @quantity >= 30
      return "HIGH"
    elsif @quantity < 30 && @quantity > 10
      return "MED"
    else
      return "LOW"
    end
  end

  def self.sort_all_by_stock_level(level)
    all_albums = Album.all()
    low_to_high = all_albums.sort_by { |album| album.quantity}
    if level == "HIGH"
      return low_to_high.reverse
    end
    return low_to_high
  end

  def self.all_stock_total()
    total = 0
    for album in Album.all() do
      album_total = album.price.to_f * album.quantity.to_f
      total += album_total
    end
    return '%.2f' % total
  end

  def self.first_char_from_titles()
    all_titles = Album.sort_all.map { |album| album.title }
    first_char_from_title = all_titles.map { |title| title[0]}
    return first_char_from_title.uniq
  end

  def self.filter_by_char(char)
    sql = "SELECT * FROM albums
          WHERE title LIKE $1;"
    values = [char + '%']
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end

  def self.sort_all_by_artist_name()
    sql = "SELECT * FROM albums
          JOIN artists
          ON artists.id = albums.artist_id
          ORDER BY artists.name;"
    results = SqlRunner.run(sql)
    return results.map { |album| Album.new(album) }
  end

  def self.exists?(album_title)
    all_album_titles = Album.all.map { |album| album.title }
    return all_album_titles.include?(album_title)
  end

  def self.find(id)
    sql = "SELECT * FROM albums
          WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Album.new(results.first)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    return results.map { |album| Album.new(album) }
  end

  def self.sort_all()
    all_albums = Album.all()
    return all_albums.sort_by { |album| album.title}
  end

  def self.delete_all_by_artist(artist_id)
    sql = "DELETE FROM albums
          WHERE artist_id = $1;"
    values = [artist_id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM albums
          WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

end
