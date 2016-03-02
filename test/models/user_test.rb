require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(email:'111',password: '123',password_confirmation: '123')
    @user2 = User.new(email:'123@qq.com',password: '123456',password_confirmation: '123456')
    @user3 = User.new(email:'111@qq.com',password: '123',password_confirmation: '123')
  end
  test "valid user" do
    assert @user2.valid?
  end

  test "have nonblank email" do
    @user.email = ''
    assert_not @user.valid?
  end


  test "should follow and unfollow a user" do
    x = users(:one)
    y = users(:two)
  	assert_not x.following?(y)
  	x.follow(y)
  	assert x.following?(y)
  	x.unfollow(y)
  	assert_not x.following?(y)
  end


  test "have long enough password" do
    @user.email = '123@qq.com'
    @user.password = "123456"
    @user.password_confirmation = "123456"
    assert @user.valid?
  end


end
