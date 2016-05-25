class SearchesController < ApplicationController
	def create
		searcher = Search.new
		@results = searcher.search(params[:search][:key_word])
		respond_to do |format|
			format .js
			format.html
		end
	end
end
