class RefactorReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reviewable_type, :string
    add_column :reviews, :reviewable_id, :integer
  end
end
