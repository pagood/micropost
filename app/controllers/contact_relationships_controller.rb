class ContactRelationshipsController < ApplicationController
	before_action :logged_in_user

	def destroy
		@contact_relationship = ContactRelationship.find(params[:id])
		@contact_relationship.destroy
		@conversation_id = params[:conversation_id]
		@conversation = Conversation.find(params[:conversation_id])
		if current_user.id == @conversation.sender_id
			@conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id}).destroy if @conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id})
			@conversation.sender_last = @conversation.messages.length
		else
			@conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id}).destroy if @conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id})
			@conversation.receiver_last = @conversation.messages.length
		end
		@conversation.save
		respond_to do |format|
			format.js
		end
	end

	def show
		@contact_relationship = ContactRelationship.find(params[:id])
		@contact = @contact_relationship.contact
		@conversation = find_conversation(current_user,@contact)
		if current_user.id == @conversation.sender_id
			@conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id}).destroy if @conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id})
			@conversation.sender_last = @conversation.messages.length
		else
			@conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id}).destroy if @conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id})
			@conversation.receiver_last = @conversation.messages.length
		end
		@conversation.save
	end
end
