class Travel < ActiveRecord::Base
  extend FriendlyId
  has_many :images, as: :imageable
  belongs_to :vehicle
  validates_presence_of :title
  friendly_id :title, use: :slugged
  accepts_nested_attributes_for :images, :allow_destroy => true
  acts_as_taggable_on :tags
  has_many :reviews, as: :reviewable
end
