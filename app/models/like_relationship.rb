class LikeRelationship < ActiveRecord::Base
	belongs_to :like, class_name: "Post"
	belongs_to :like_user, class_name: "User"

	has_many :unread_likes,dependent: :destroy
	has_many :users,through: :unread_likes,dependent: :destroy
end
