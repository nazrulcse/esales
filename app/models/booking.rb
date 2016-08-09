class Booking < ActiveRecord::Base
  belongs_to :bookable, polymorphic: true
  validates_presence_of :name, :email, :mobile
  belongs_to :user
end
