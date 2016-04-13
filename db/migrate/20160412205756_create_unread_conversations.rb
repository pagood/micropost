class CreateUnreadConversations < ActiveRecord::Migration
  def change
    create_table :unread_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.timestamps null: false
    end
    add_index :unread_conversations,:user_id
    add_index :unread_conversations,:conversation_id
    add_index :unread_conversations,[:user_id,:conversation_id],unique: true
  end
end
