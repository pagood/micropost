class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create,:destroy]
	before_action :correct_user,only: :destroy
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to root_url
		else 
			@feed = []
			render 'static_pages/home'
		end

	end

	def destroy
		@post.destroy
		flash[:success] = "deleted"
		redirect_to request.referrer
	end

	private 
	def post_params
		params.require(:post).permit(:content,:photo)
	end
	
	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end

end
