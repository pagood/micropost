class RelationshipsController < ApplicationController
	before_action :logged_in_user
	def create 
		@user = User.find(params[:following_id])
		@radar = params[:radar]
		@last = params[:last]
		relationship = current_user.follow(@user)
		@user.unread_followers.create({user_id:@user.id,relationship_id:relationship.id})
		@next = next_recommended_user(@last) unless @radar.nil?
		respond_to do |format|
			format .js
		end
	end

	def destroy
		@user = User.find(params[:following_id])
		relationship_id = Relationship.find_by({follower_id:current_user.id,following_id:@user.id}).id
		current_user.unfollow(@user)
		@user.unread_followers.find_by({user_id:@user.id,relationship_id:relationship_id}).destroy if @user.unread_followers.find_by({user_id:@user.id,relationship_id:relationship_id})
		respond_to do |format|
			format .js
		end
	end
end
