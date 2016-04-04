class ContactRelationshipsController < ApplicationController
	before_action :logged_in_user

	def destroy
		@contact_relationship = ContactRelationship.find(params[:id])
		@contact_relationship.destroy
		@conversation_id = params[:conversation_id]
		respond_to do |format|
			format.js
		end
	end
end
