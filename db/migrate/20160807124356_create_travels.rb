class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :title
      t.date :from_date
      t.date :to_date
      t.time :time
      t.integer :vehicle_id
      t.float :price
      t.string :offer
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
