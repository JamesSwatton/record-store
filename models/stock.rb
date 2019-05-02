class Stock
  #
  attr_reader :id, :artist_id, :album_id, :stock_level

  def initialize(options)
    # @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']
    @album_title = options['album_title']
    @stock_level = options['stock_level'].to_i
  end

end
