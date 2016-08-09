class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  mount_uploader :image, ImageUploader
  has_many :orders
  has_many :sales
  has_many :favorites
  has_many :reviews
  has_many :subscriber_transactions
  has_many :bookings
end
