class Bill < ActiveRecord::Base
  belongs_to :vendor
  has_many :slices
  has_many :payments, :through => :slices

  attr_accessible :vendor, :issue_date, :due_date, :slices

  validates :vendor,      :presence => true
  validates :issue_date,  :presence => true
  validates :due_date,    :presence => true,
                          :date => {
                              :after => :issue_date
                          }

  def total_due
    slices.map(&:amount).sum
  end

  def total_paid
    payments.map(&:amount).sum
  end

end
