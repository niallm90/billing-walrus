class Payment < ActiveRecord::Base
  belongs_to :slice
  belongs_to :user

  attr_accessible :amount, :slice_id

  validates :amount, :numericality => {
                        :greater_than => 0,
                        :only_integer => true
                      }
  validates :slice, :presence => true

  delegate :user, :to => :slice

end
