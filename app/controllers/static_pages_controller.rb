class StaticPagesController < ApplicationController
	def home
		if logged_in?
			flash[:info] = "Please check your email to activate your account." unless current_user.activated?
			@post = current_user.posts.build
			if params[:last]
				@feed = current_user.feed(params[:last])
			else
				@feed = current_user.feed_without_params
			end
			# @feed = current_user.feed_without_params
			# render :text => @feed.first.user.inspect
		end
	end

	def test
		@feed = Post.all.limit(5)
	end
end
