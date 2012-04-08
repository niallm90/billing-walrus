class Vendor < ActiveRecord::Base
  has_and_belongs_to_many :services
  has_many :bills

  validates :name, :presence => true

  attr_accessible :name, :service_ids
end
