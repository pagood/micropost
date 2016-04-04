class ContactRelationship < ActiveRecord::Base
	belongs_to :me,class_name: "User"
	belongs_to :contact,class_name: "User"
	validates :me_id,presence: true
	validates :contact_id,presence: true
	default_scope -> { order(created_at: :desc) }
end
