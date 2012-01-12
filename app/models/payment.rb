class Payment < ActiveRecord::Base
  belongs_to :slice
  belongs_to :user
end
