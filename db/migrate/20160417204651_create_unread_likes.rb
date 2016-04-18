class CreateUnreadLikes < ActiveRecord::Migration
  def change
    create_table :unread_likes do |t|
      t.integer :like_relationship_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :unread_likes,:user_id
    add_index :unread_likes,:like_relationship_id
    add_index :unread_likes,[:user_id,:like_relationship_id],unique: true
  end
end
