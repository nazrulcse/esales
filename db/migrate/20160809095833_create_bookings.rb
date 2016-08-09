class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :bookable_type
      t.integer :bookable_id
      t.string :name
      t.string :email
      t.string :mobile
      t.text :address
      t.integer :quantity, default: 1
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
