class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :photo
      t.string :name
      t.string :bio
      t.string :website
      t.references :user
      t.timestamps null: false
    end
  end
end
