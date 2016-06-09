class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :image
      t.string :header
      t.string :header_bold
      t.string :header_small
      t.float :off
      t.string :link

      t.timestamps null: false
    end
  end
end
