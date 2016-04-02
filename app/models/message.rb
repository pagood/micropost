class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	validates_presence_of :content, :conversation_id, :user_id
end
