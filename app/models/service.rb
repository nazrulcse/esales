class Service < ActiveRecord::Base
  extend FriendlyId
  validates_presence_of :name
  acts_as_taggable_on :tags
  friendly_id :name, use: :slugged
  has_many :images, :as => :imageable
  has_many :relateds, as: :relatable
  has_many :reviews, as: :reviewable
  has_many :bookings, as: :bookable
  belongs_to :category
  accepts_nested_attributes_for :images, :allow_destroy => true

  def title
    name
  end
end
