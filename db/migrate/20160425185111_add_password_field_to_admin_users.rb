class AddPasswordFieldToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :password, :string
    add_column :users, :password, :string
  end
end
