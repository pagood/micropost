require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.first
  	@post = Post.new(content: 'hello world',user_id: @user.id)
  end
  test "post should vaild" do
  	assert @post.valid?
  end
end
