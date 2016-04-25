class ProductImage < ActiveRecord::Base
  belongs_to :product
  mount_uploader :image, ProductImagesUploader
end
