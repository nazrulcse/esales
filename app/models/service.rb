class Service < ActiveRecord::Base
  extend FriendlyId
  acts_as_taggable_on :tags
  friendly_id :name, use: :slugged
  has_many :product_images, :as => :product_imageable
  mount_uploader :image, ProductImagesUploader
  has_many :service_relations
  belongs_to :category
  has_many :related_service, through: :service_relations, foreign_key: 'related_service_id'
  # has_many :line_items, :as => :line_itemable
  accepts_nested_attributes_for :product_images, :allow_destroy => true
end
