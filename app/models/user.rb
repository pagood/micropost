class User < ActiveRecord::Base
	attr_accessor :remember_token,:activation_token,:reset_token
	before_save {self.email = email.downcase}
	before_create :create_activation_digest
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,presence: true,length: {maximum:255},format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive:false}
	validates :user_name,presence: true,length: {maximum:26},uniqueness: true
	validates :name,length: {maximum:26}
	validates :bio,length: {maximum:150}
	validates :password,presence: true,length: { minimum: 6},allow_nil: true
	validate  :avatar_size
	has_secure_password
	has_many :posts,dependent: :destroy
	has_many :comments,dependent: :destroy
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followings, through: :active_relationships
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
	has_many :followers, through: :passive_relationships
	has_many :like_relationships,dependent: :destroy,foreign_key: "like_user_id"
	has_many :likes,through: :like_relationships,dependent: :destroy


	mount_uploader :avatar, AvatarUploader
	#shared
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest,User.digest(remember_token))
	end

	def authenticated?(attribute,token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end
	#activation
	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(self.activation_token)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end
	#password reset
	def create_reset_digest
		self.reset_token = User.new_token
		self.update_attribute(:reset_digest,User.digest(reset_token))
		self.update_attribute(:reset_sent_at,Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hour.ago
	end
	#like dislike
	def like(post)
		like_relationships.create(like_id: post.id)
	end

	def dislike(post)
		like_relationships.find_by(like_id: post.id).destroy
	end

	#following follower
	def follow(other_user) 
		active_relationships.create(following_id: other_user.id)
	end
	def unfollow(other_user)
		active_relationships.find_by(following_id: other_user.id).destroy
	end
	def following?(other_user)
		followings.include?(other_user)
	end
	def feed(last)
		following_ids = "SELECT following_id FROM relationships
		WHERE  follower_id = :user_id"
		Post.where("(user_id IN (#{following_ids})
			OR user_id = :user_id) AND id < :last_id",user_id: id,last_id: last).limit(5)
	end

	def feed_without_params
		following_ids = "SELECT following_id FROM relationships
		WHERE  follower_id = :user_id"
		Post.where("user_id IN (#{following_ids})
			OR user_id = :user_id",user_id: id).limit(5)
	end

	def posts_with_last(last)
		posts.where("id < :last",last: last).limit(5)
	end

	def avatar_size
      if avatar.size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB")
      end
    end
	
end
