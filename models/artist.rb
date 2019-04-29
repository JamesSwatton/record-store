require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    name = swap_the()
    sql = "INSERT INTO artists (name)
          VALUES ($1)
          RETURNING id;"
    values = [name]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def update()
    # name = swap_the
    sql = "UPDATE artists
          SET name = $1
          WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def albums()
    sql = "SELECT * FROM albums
          WHERE artist_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album)}
  end

  def swap_the()
    if @name.start_with?("The ") || @name.end_with?("The")
      split_string = @name.split
      # binding.pry
      if split_string[0] == "The"
        string_without_the = split_string[1..-1].join(" ")
        put_the_to_end = string_without_the + " " + split_string[0]
        return put_the_to_end
      else
        string_without_the = split_string[0..-2].join(" ")
        put_the_to_start = split_string[-1] + " " + string_without_the
        return put_the_to_start
      end
    end
    return @name
  end

  def self.first_char_from_names()
    all_names = Artist.sort_all.map { |artist| artist.name }
    first_char_from_names = all_names.map { |name| name[0]}
    return first_char_from_names.uniq
  end

  def self.filter_by_char(char)
    sql = "SELECT * FROM artists
          WHERE name LIKE $1;"
    values = [char + '%']
    results = SqlRunner.run(sql, values)
    return results.map { |artist| Artist.new(artist) }
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

  def self.all_names()
    all_artists = Artist.all()
    artist_names = all_artists.map { |artist| artist.name }
    return artist_names
  end

  def self.find(id)
    sql = "SELECT * FROM artists
          WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Artist.new(results.first)
  end

  def self.exists?(artist_name)
    all_artist_names = Artist.all.map { |artist| artist.name }
    return all_artist_names.include?(artist_name)
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
