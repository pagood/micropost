class LikeRelationshipsController < ApplicationController
	before_action :logged_in_user
	def create
		@post = Post.find_by(id: params[:post_id])
		current_user.like(@post)
		respond_to do |format|
			format .js
			format.html {redirect_to root_url}
		end
	end

	def destroy
		@post = Post.find_by(id: params[:post_id])
		current_user.dislike(@post)
		respond_to do |format|
			format .js
			format.html {redirect_to root_url}
		end
	end

end
