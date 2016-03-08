class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :conversation_id
      t.text :content
      t.timestamps null: false
    end
    add_index :messages,:sender_id
    add_index :messages,:receiver_id
    add_index :messages,[:sender_id,:receiver_id]
  end
end
