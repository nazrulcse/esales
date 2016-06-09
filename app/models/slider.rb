class Slider < ActiveRecord::Base
  mount_uploader :image, SliderUploader
end
