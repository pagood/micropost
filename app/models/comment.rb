class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	belongs_to :comment,class_name:"Comment",foreign_key: "reply_id"
	default_scope -> { order(created_at: :desc) }
	validates :post_id,presence: true
	validates :user_id,presence: true
	validates :content,presence: true,length: { maximum: 140}
	has_many :replys,class_name: "Comment",dependent: :destroy,foreign_key: "reply_id"
	
end
