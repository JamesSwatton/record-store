require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    if @name.start_with?("The")
      @name = @name.split.reverse.join(" ")
    end
    sql = "INSERT INTO artists (name)
          VALUES ($1)
          RETURNING id;"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums
          WHERE artist_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album)}
  end

  def self.first_char_from_names()
    all_names = Artist.sort_all.map { |artist| artist.name }
    all_names_uniq = all_names.uniq
    first_char_from_names = all_names_uniq.map { |name| name[0]}
    return first_char_from_names
  end

  def self.all()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    return results.map { |artist| Artist.new(artist) }
  end

  def self.sort_all()
    all_artists = Artist.all()
    return all_artists.sort_by { |artist| artist.name}
  end

  def self.find(id)
    sql = "SELECT * FROM artists
          WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Artist.new(results.first)
  end

  def self.find_id_by_name(name)
    sql = "SELECT id FROM artists
          WHERE name = $1"
    values = [name]
    results = SqlRunner.run(sql, values)
    return results.first['id'].to_i
  end

  def self.delete(id)
    sql = "DELETE FROM artists
          WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

end
