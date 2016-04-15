class MessagesController < ApplicationController
	before_action :logged_in_user
	def create
		@conversation = Conversation.find(params[:message][:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.user_id = current_user.id 
		@message.save!
		@path = conversation_path(@conversation)

		if @conversation.sender_id == current_user.id
			
			@conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id}).destroy if @conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id})
			@conversation.receiver.unread_conversations.create({user_id:@conversation.receiver_id,conversation_id:@conversation.id}) unless @conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id})
			@conversation.sender_last = @conversation.messages.length
			@conversation.save

			@user = @conversation.receiver
			@user_path = user_path(@conversation.receiver)
		else

			@conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id}).destroy if @conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id})
			@conversation.sender.unread_conversations.create({user_id:@conversation.sender_id,conversation_id:@conversation.id}) unless @conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id})
			@conversation.receiver_last = @conversation.messages.length
			@conversation.save

			@user = @conversation.sender
			@user_path = user_path(@conversation.sender)
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
