class CreateRelateds < ActiveRecord::Migration
  def change
    create_table :relateds do |t|
      t.string :relatable_type
      t.integer :relatable_id

      t.timestamps null: false
    end
  end
end
