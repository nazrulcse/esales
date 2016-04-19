class AddUserFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :father_name, :string
    add_column :users, :mother_name, :string
    add_column :users, :date_of_birth, :string
    add_column :users, :permanent_address, :text
    add_column :users, :present_address, :text
    add_column :users, :voter_id, :string
    add_column :users, :mobile, :string
    add_column :users, :identifier_name, :string
    add_column :users, :identifier_mobile, :string
    add_column :users, :identifier_address, :text
    add_column :users, :user_type, :text
  end
end
