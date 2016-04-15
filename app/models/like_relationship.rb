class LikeRelationship < ActiveRecord::Base
	belongs_to :like, class_name: "Post"
	belongs_to :like_user, class_name: "User"
	
end
