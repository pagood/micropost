class CreateContactRelationships < ActiveRecord::Migration
  def change
    create_table :contact_relationships do |t|
      t.integer :me_id
      t.integer :contact_id
      t.timestamps null: false
    end
    add_index :contact_relationships, :me_id
    add_index :contact_relationships, [:me_id,:contact_id], unique: true
  end
end
