class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :slice

  attr_accessible :amount, :user, :slice

  validates :amount, :numericality => {
                        :greater_than => 0,
                        :only_integer => true
                      }
  validates :user, :presence => true
  validates :slice, :presence => true

end
