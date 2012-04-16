class Slice < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill
  has_many :payments, :dependent => :destroy

  attr_accessible :amount, :user_id, :bill_id, :payments

  validates :amount, :numericality => {
                        :greater_than => 0
                      }
  validates :user, :presence => true
  validates :bill, :presence => true

  def total_paid
    payments.map(&:amount).sum
  end

end
