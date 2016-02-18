class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :photo
      t.string :content
      t.integer :likes
      t.references :user
      t.timestamps null: false
    end
  end
end
