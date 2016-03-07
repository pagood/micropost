class AddLikeRelationship < ActiveRecord::Migration
  def change
  	create_table :likes do |t|
      t.integer :like_id
      t.integer :like_user_id
      t.timestamps null: false
    end
    add_index :likes, :like_id
    add_index :likes, :like_user_id
    add_index :likes, [:like_id,:like_user_id], unique: true
  end
end
