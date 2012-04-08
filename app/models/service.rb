class Service < ActiveRecord::Base

  has_and_belongs_to_many :vendors

  validates :name, :presence => true

  attr_accessible :name, :vendor_ids

end
