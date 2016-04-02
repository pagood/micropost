class Conversation < ActiveRecord::Base
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "User"
	has_many :messages
	validates :sender_id,presence: true
	validates :receiver_id,presence: true
	validates_uniqueness_of :sender_id, :scope => :receiver_id
end
