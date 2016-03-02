class AddColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :user_name, :string
  	add_column :users, :phone, :string
  	add_column :users, :sex, :string
  	add_column :users, :bio, :string
  	add_column :users, :website, :string
  end
end
