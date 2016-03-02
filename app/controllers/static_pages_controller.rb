class StaticPagesController < ApplicationController
	respond_to :html, :js
	def home
		if logged_in?
			@post = current_user.posts.build
			
			if params[:id]
				@feed = current_user.feed(params[:id])
			else
				@feed = current_user.feed_without_params
			end
			# @feed = current_user.feed_without_params
		end
	end
end
