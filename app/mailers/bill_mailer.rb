class BillMailer < ActionMailer::Base
  def bill_email(bill)
    @bill = bill
    recipients = bill.slices.each.collect(&:user).each.collect(&:email)
    mail(:bcc => recipients, :subject => "New Bill from #{bill.vendor.name}")
  end
end
