class User < ActiveRecord::Base
	has_secure_password
	has_many :posts
	has_many :comments
	has_one :profile
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followings, through: :active_relationships
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
	has_many :followers, through: :passive_relationships
	def follow(other_user) 
		active_relationships.create(following_id: other_user.id)
	end
	def unfollow(other_user)
		active_relationships.find_by(following_id: other_user.id).destroy
	end
	def following?(other_user)
		followings.include?(other_user)
	end
	def feed
	end
end
