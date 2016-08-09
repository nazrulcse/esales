class Travel < ActiveRecord::Base
  extend FriendlyId
  has_many :images, as: :imageable
  belongs_to :vehicle
  validates_presence_of :title
  friendly_id :title, use: :slugged
  accepts_nested_attributes_for :images, :allow_destroy => true
  acts_as_taggable_on :tags
  has_many :reviews, as: :reviewable
  has_many :bookings, as: :bookable

  def trip_date
    if from_date.present? && to_date.present?
      from_date.strftime('%b %d, %Y') + ' - ' + to_date.strftime('%b %d, %Y')
    elsif from_date.present?
      from_date.strftime('%b %d, %Y')
    elsif to_date.present?
      to_date.strftime('%b %d, %Y')
    end
  end
end
