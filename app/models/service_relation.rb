class ServiceRelation < ActiveRecord::Base
  belongs_to :service
  belongs_to :related_service, class_name: 'Service', foreign_key: 'related_service_id'
end
