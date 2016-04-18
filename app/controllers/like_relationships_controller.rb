class LikeRelationshipsController < ApplicationController
	before_action :logged_in_user
	def create
		@post = Post.find_by(id: params[:post_id])
		like_relationship = current_user.like(@post)
		@post.user.unread_likes.create({user_id: @post.user.id,like_relationship_id:like_relationship.id}) if @post.user.id != current_user.id
		if @post.user.id != current_user.id
			@user = @post.user
		end
		respond_to do |format|
			format .js
			format.html {redirect_to root_url}
		end
	end

	def destroy
		@post = Post.find_by(id: params[:post_id])
		like_relationship = current_user.dislike(@post)
		@post.user.unread_likes.find_by({user_id: @post.user.id,like_relationship_id:like_relationship.id}).destroy if @post.user.unread_likes.find_by({user_id: @post.user.id,like_relationship_id:like_relationship.id})
		if @post.user.id != current_user.id
			@user = @post.user
		end
		respond_to do |format|
			format .js
			format.html {redirect_to root_url}
		end
	end

end
