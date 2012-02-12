class Vendor < ActiveRecord::Base
  has_and_belongs_to_many :services
  has_many :bills
end
