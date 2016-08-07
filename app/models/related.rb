class Related < ActiveRecord::Base
  belongs_to :relatable, polymorphic: true
end
