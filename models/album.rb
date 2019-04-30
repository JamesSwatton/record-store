require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_reader :id, :title, :artist_id
  attr_accessor :quantity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @quantity = options['quantity'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, artist_id, quantity)
          VALUES ($1,$2,$3)
          RETURNING id;"
    values = [@title, @artist_id, @quantity]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def update()
    sql = "UPDATE albums
          SET (title, artist_id, quantity) = ($1,$2,$3)
          WHERE id = $4"
    values = [@title, @artist_id, @quantity, @id]
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

  def self.sort_all_by_artist_name()
    sql = "SELECT albums.id, albums.title, albums.artist_id, albums.quantity
          FROM albums
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
