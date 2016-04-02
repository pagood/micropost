class AddLastToConversation < ActiveRecord::Migration
  def change
  	add_column :conversations,:sender_last,:integer,default: 0
  	add_column :conversations,:receiver_last,:integer,default: 0
  end
end
