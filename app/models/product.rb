class Product < ActiveRecord::Base
  mount_uploader :image, ProductImagesUploader
  belongs_to :category
  belongs_to :brand
  serialize :images
  # attr_accessible :product_images_attributes
  has_many :product_images

# your_model.rb (add after relations)
  accepts_nested_attributes_for :product_images, :allow_destroy => true
end
