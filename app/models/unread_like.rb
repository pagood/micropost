class UnreadLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :like_relationship
	validates_presence_of :user_id, :like_relationship_id
end
