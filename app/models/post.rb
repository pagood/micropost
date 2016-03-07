class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments,dependent: :destroy
	has_many :like_relationships,dependent: :destroy,foreign_key: "like_id"
	has_many :like_users,through: :like_relationships,dependent: :destroy

	default_scope -> { order(created_at: :desc) }
	validates :user_id,presence: true
	validates :content,length: {maximum: 140}
	validate :photo_size
	validate :has_content
	#associate
	mount_uploader :photo, PictureUploader

	def has_content
		unless [content?,photo?].include?(true)
			errors.add :base, 'you can not post nothing'
			
		end
	end
	private 
	def photo_size
		if photo.size > 5.megabytes
			errors.add(:photo, "should be less than 5MB")
		end
	end
end
