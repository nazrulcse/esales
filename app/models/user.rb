class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,:registerable
  mount_uploader :image, ImageUploader
  has_many :orders
  has_many :favorites
  has_many :reviews
end
