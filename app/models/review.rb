class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :reviewable, polymorphic: true
end
