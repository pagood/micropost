class Conversation < ActiveRecord::Base
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "User"
	has_many :messages

	has_many :unread_conversations,dependent: :destroy
	has_many :users,through: :unread_conversations,dependent: :destroy

	validates :sender_id,presence: true
	validates :receiver_id,presence: true
	validates_uniqueness_of :sender_id, :scope => :receiver_id
end
