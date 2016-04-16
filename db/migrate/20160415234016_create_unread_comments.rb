class CreateUnreadComments < ActiveRecord::Migration
  def change
    create_table :unread_comments do |t|
      t.integer :user_id
      t.integer :comment_id
      t.timestamps null: false
    end
    add_index :unread_comments,:user_id
    add_index :unread_comments,:comment_id
    add_index :unread_comments,[:user_id,:comment_id],unique: true
  end
end
