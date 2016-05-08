class Service < ActiveRecord::Base
  mount_uploader :image, ProductImagesUploader
end
