class RelationshipsController < ApplicationController
	before_action :logged_in_user
	def create 
		@user = User.find(params[:following_id])
		@radar = params[:radar]
		@last = params[:last]
		current_user.follow(@user)
		@next = next_recommended_user(@last) unless @radar.nil?
		respond_to do |format|
			format .js
		end
	end

	def destroy
		@user = User.find(params[:following_id])
		current_user.unfollow(@user)
		respond_to do |format|
			format .js
		end
	end
end
