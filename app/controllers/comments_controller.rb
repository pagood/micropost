class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create,:destroy,:index]
	before_action :correct_user,only: :destroy
	def create
		comment = current_user.comments.build(comment_params)
		comment.save
		unless comment.reply_id
			comment.post.user.unread_comments.create({user_id:comment.post.user.id,comment_id:comment.id}) if comment.post.user.id != comment.user.id
			if comment.post.user.id != comment.user.id
				redirect_to comments_path(post_id: params[:comment][:post_id],user_id: comment.post.user.id )
			else
				redirect_to comments_path(post_id: params[:comment][:post_id])
			end
		else
			Comment.find(comment.reply_id).user.unread_replies.create({user_id:Comment.find(comment.reply_id).user.id,comment_id:comment.id}) if comment.user.id != Comment.find(comment.reply_id).user.id
			if comment.user.id != Comment.find(comment.reply_id).user.id
				redirect_to comments_path(post_id: params[:comment][:post_id],user_id: Comment.find(comment.reply_id).user.id )
			else
				redirect_to comments_path(post_id: params[:comment][:post_id])
			end
		end
	end

	def destroy
		post_id = @comment.post.id
		unless @comment.reply_id
			@comment.post.user.unread_comments.find_by({user_id:@comment.post.user.id,comment_id:@comment.id}).destroy if @comment.post.user.unread_comments.find_by({user_id:@comment.post.user.id,comment_id:@comment.id})
			@comment.destroy
			if @comment.post.user.id != @comment.user.id
				redirect_to comments_path(post_id: post_id,user_id:@comment.post.user.id), status: 303
			else
				redirect_to comments_path(post_id: post_id), status: 303
			end
		else
			Comment.find(@comment.reply_id).user.unread_replies.find_by({user_id:Comment.find(@comment.reply_id).user.id,comment_id:@comment.id}).destroy if Comment.find(@comment.reply_id).user.unread_replies.find_by({user_id:Comment.find(@comment.reply_id).user.id,comment_id:@comment.id})
			@comment.destroy
			if @comment.user.id != Comment.find(@comment.reply_id).user.id
				redirect_to comments_path(post_id: post_id,user_id:Comment.find(@comment.reply_id).user.id), status: 303
			else
				redirect_to comments_path(post_id: post_id), status: 303
			end
		end

		
		
	end

	def index
		#check if there is comments not showing
		@user = User.find(params[:user_id]) if params[:user_id]
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
