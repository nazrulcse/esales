class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
