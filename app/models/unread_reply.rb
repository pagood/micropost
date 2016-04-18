class UnreadReply < ActiveRecord::Base
	belongs_to :user
	belongs_to :comment
	validates_presence_of :user_id, :comment_id
end
