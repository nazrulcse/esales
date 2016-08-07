class Product < ActiveRecord::Base
  PRODUCT_TYPES = {
      product: 'products',
      service: 'services'
  }
  extend FriendlyId
  belongs_to :category
  belongs_to :brand
  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags
  has_many :images, as: :imageable
  has_many :favorites
  has_many :sales
  has_many :reviews
  has_many :product_relations
  has_many :related_product, through: :product_relations, foreign_key: 'related_product_id'

  accepts_nested_attributes_for :images, :allow_destroy => true

end
