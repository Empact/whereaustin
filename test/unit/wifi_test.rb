require File.dirname(__FILE__) + '/../test_helper'

class WifiTest < Test::Unit::TestCase
  fixtures :wifis

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Wifi, wifis(:first)
  end
end
