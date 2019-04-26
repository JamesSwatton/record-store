require('minitest/autorun')
require('minitest/rg')
require_relative('../models/artist')


class TestArtist < MiniTest::Test

  def test_find_artist
    result = Artist.find(13).name
    assert_equal("The Beatles", result)
  end

  def test_get_all_artists
    results = Artist.all()
    assert_equal(2, results.count)
  end

end
