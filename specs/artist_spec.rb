require('minitest/autorun')
require('minitest/rg')
require_relative('../models/artist')


class TestArtist < MiniTest::Test

  def test_find_artist
    result = Artist.find(13).name
    assert_equal("The Beatles", result)
  end

end
