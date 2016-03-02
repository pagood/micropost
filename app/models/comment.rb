class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	default_scope -> { order(created_at: :desc) }
	validates :post_id,presence: true
	validates :content,presence: true,length: { maximum: 140}
end
