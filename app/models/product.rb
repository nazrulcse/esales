class Product < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ProductImagesUploader
  belongs_to :category
  belongs_to :brand
  serialize :images
  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags
  # attr_accessible :product_images_attributes
  has_many :product_images
  has_many :favorites
  has_many :reviews
  has_many :product_relations
  has_many :related_product, through: :product_relations, foreign_key: 'related_product_id'

# your_model.rb (add after relations)
  accepts_nested_attributes_for :product_images, :allow_destroy => true

  # def to_param
  #   if caller.to_s.include?"active_admin"
  #     id && id.to_s
  #   else
  #     slug
  #   end
  # end

  # searchable do
  #   text :name
  #   text :description
  #   text :category do
  #     category.name
  #   end
  #
  #   text :brand do
  #     brand.name
  #   end
  # end
end
