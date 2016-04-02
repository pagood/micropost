class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.references :conversation
      t.timestamps null: false
      t.text :content
    end
  end
end
