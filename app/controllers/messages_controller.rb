class MessagesController < ApplicationController
	def create
		@conversation = Conversation.find(params[:message][:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.user_id = current_user.id 
		@message.save!
		@path = conversation_path(@conversation)

		if @conversation.sender_id == current_user.id
			@conversation.sender_last = @conversation.messages.length
			@conversation.save
		else
			@conversation.receiver_last = @conversation.messages.length
			@conversation.save
		end

		respond_to do |format|
			format.js
		end
	end
	private
	def message_params
		params.require(:message).permit(:content)
	end
end
