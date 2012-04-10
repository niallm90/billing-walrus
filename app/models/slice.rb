class Slice < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill
  has_many :payments, :dependent => :destroy

  attr_accessible :amount, :user, :bill, :payments

  validates :amount, :numericality => {
                        :greater_than => 0,
                        :only_integer => true
                      }
  validates :user, :presence => true
  validates :bill, :presence => true

  def total_paid
    payments.map(&:amount).sum
  end

end
