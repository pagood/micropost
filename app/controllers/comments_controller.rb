class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create,:destroy,:index]
	before_action :correct_user,only: :destroy
	def create
		comment = current_user.comments.build(comment_params)
		comment.save
		redirect_to comments_path(post_id: params[:comment][:post_id])
	end

	def destroy
		post_id = @comment.post.id
		@comment.destroy
		redirect_to comments_path(post_id: post_id), status: 303
	end

	def index
		#check if there is comments not showing
		if params[:id].nil?
			@post = Post.find_by(id: params[:post_id])
			@comments = @post.comments.limit(5)
			if @post.comments.count > 5
				@flag = true
			else
				@flag = false
			end
			respond_to do |format|
				format .js
				format.html {redirect_to root_url}
			end
		else
			@post = Post.find_by(id: params[:post_id])
			@comments = @post.comments.where("id < :last",last:params[:id]).limit(5)
			if @post.comments.where("id < :last",last:params[:id]).count > 5
				@flag = true
			else
				@flag = false
			end
			respond_to do |format|
				format .js
				format.html {redirect_to root_url}
			end
		end
	end

	def load

	end

	private 
	def comment_params
		params.require(:comment).permit(:content,:post_id,:reply_id)
	end

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to root_url if @comment.nil?
	end
end
