class AddUnitFieldToProducts < ActiveRecord::Migration
  def change
    add_column :products, :unit, :string
    add_column :products, :product_type, :string
  end
end
