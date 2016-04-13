class ConversationsController < ApplicationController
	layout false
	before_action :logged_in_user
	def show
		@conversation = Conversation.find(params[:id])
		if @conversation.sender_id == current_user.id
			@conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id}).destroy if @conversation.sender.unread_conversations.find_by({user_id:@conversation.sender_id,conversation_id:@conversation.id})
			@last = @conversation.sender_last
			@conversation.sender_last = @conversation.messages.length
			@conversation.save
			@contact = @conversation.receiver_id
		else
			@conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id}).destroy if @conversation.receiver.unread_conversations.find_by({user_id:@conversation.receiver_id,conversation_id:@conversation.id})
			@last = @conversation.receiver_last
			@conversation.receiver_last = @conversation.messages.length
			@conversation.save
			@contact = @conversation.sender_id
		end
		@contact_relationship = ContactRelationship.find_by(me_id:current_user.id,contact_id:@contact)
		respond_to do |format|
			format.js
		end
	end
	def create
		sender = User.find(params[:sender_id])
		receiver = User.find(params[:receiver_id])
		current_user.contact_relationships.create({me_id:sender.id,contact_id:receiver.id}) unless ContactRelationship.find_by(me_id:current_user.id,contact_id:receiver.id)
		@conversation = find_conversation(sender,receiver)
		@conversation = Conversation.create({sender_id: sender.id,receiver_id:receiver.id}) unless @conversation
		redirect_to @conversation
	end
end
