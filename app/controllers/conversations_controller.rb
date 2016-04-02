class ConversationsController < ApplicationController
	layout false
	def show
		@conversation = Conversation.find(params[:id])
		if @conversation.sender_id == current_user.id
			@last = @conversation.sender_last
			@conversation.sender_last = @conversation.messages.length
			@conversation.save
		else
			@last = @conversation.receiver_last
			@conversation.receiver_last = @conversation.messages.length
			@conversation.save
		end
	end
end
