class StaticPagesController < ApplicationController
	respond_to :html, :js
	def home
		if logged_in?
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
end
