class UnreadFollower < ActiveRecord::Base
	belongs_to :user
	belongs_to :relationship
	validates_presence_of :user_id, :relationship_id
end
