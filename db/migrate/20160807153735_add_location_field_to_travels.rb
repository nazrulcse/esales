class AddLocationFieldToTravels < ActiveRecord::Migration
  def change
    add_column :travels, :location, :string
    add_column :travels, :lat, :float
    add_column :travels, :lng, :float
  end
end
