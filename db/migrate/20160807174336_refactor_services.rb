class RefactorServices < ActiveRecord::Migration
  def change
    remove_column :services, :image, :string
    add_column :services, :is_featured, :boolean
    add_column :services, :category_id, :integer
    add_column :services, :slug, :string
  end
end
