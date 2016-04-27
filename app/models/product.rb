class Product < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ProductImagesUploader
  belongs_to :category
  belongs_to :brand
  serialize :images
  friendly_id :name, use: :slugged
  # attr_accessible :product_images_attributes
  has_many :product_images

# your_model.rb (add after relations)
  accepts_nested_attributes_for :product_images, :allow_destroy => true

  def to_param
    if caller.to_s.include?"active_admin"
      id && id.to_s
    else
      slug
    end
  end
end
