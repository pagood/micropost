class CreateUnreadReplies < ActiveRecord::Migration
  def change
    create_table :unread_replies do |t|
      t.integer :user_id
      t.integer :comment_id
      t.timestamps null: false
    end
    add_index :unread_replies,:user_id
    add_index :unread_replies,:comment_id
    add_index :unread_replies,[:user_id,:comment_id],unique:true
  end
end
