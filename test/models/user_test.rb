require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should follow and unfollow a user" do
  	x = users(:one)
  	y = users(:two)
  	assert_not x.following?(y)
  	x.follow(y)
  	assert x.following?(y)
  	x.unfollow(y)
  	assert_not x.following?(y)
  end

  test "feed should have the right posts" do
    x = users(:one)
    y = users(:two)
    
  end
end
