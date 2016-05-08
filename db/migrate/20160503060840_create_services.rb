class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.text :image
      t.float :price
      t.string :unit
      t.timestamps null: false
    end
  end
end
