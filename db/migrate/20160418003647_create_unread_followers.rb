class CreateUnreadFollowers < ActiveRecord::Migration
  def change
    create_table :unread_followers do |t|
      t.integer :user_id
      t.integer :relationship_id
      t.timestamps null: false
    end
    add_index :unread_followers,:user_id
    add_index :unread_followers,:relationship_id
    add_index :unread_followers,[:user_id,:relationship_id],unique: true
  end
end
