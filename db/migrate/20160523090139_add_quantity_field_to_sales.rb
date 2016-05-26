class AddQuantityFieldToSales < ActiveRecord::Migration
  def change
    add_column :sales, :quantity, :integer
  end
end
