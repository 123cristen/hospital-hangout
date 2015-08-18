require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Hospital Hangout"
    assert_equal full_title("Help"), "Help | Hospital Hangout"
  end
end