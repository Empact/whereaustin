require File.dirname(__FILE__) + '/../test_helper'

class SxswMusicEventTest < Test::Unit::TestCase
  fixtures :sxsw_music_events

  # Replace this with your real tests.
  def test_truth
    assert_kind_of SxswMusicEvent, sxsw_music_events(:first)
  end
end
