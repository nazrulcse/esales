class AddNewFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_guest, :boolean, default: false
    add_column :orders, :user_id, :integer
    add_column :orders, :email, :string
    add_column :orders, :mobile, :string
    add_column :orders, :city, :string
    add_column :orders, :zip, :integer
    add_column :orders, :name, :string
    add_column :orders, :address, :text
    add_column :orders, :status_id, :integer
  end
end
