class Slice < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill

  attr_accessible :amount, :user, :bill

  validates :amount, :numericality => {
                        :greater_than => 0,
                        :only_integer => true
                      }
  validates :user, :presence => true
  validates :bill, :presence => true

end
