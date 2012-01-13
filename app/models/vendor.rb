class Vendor < ActiveRecord::Base
  belongs_to :service
  has_many :bills
end
