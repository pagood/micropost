class CreateLikeRelationships < ActiveRecord::Migration
  def change
    create_table :like_relationships do |t|
      t.integer :like_id
      t.integer :like_user_id
      t.timestamps null: false
    end
    add_index :like_relationships, :like_id
    add_index :like_relationships, :like_user_id
    add_index :like_relationships, [:like_id,:like_user_id], unique: true
  end
end
