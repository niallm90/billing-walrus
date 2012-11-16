require "spec_helper"

describe BillMailer do

  before(:all) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  let(:bill) { FactoryGirl.create :bill }
  let(:bill_email) { BillMailer.bill_email(bill) }

  describe "user is sent a bill email" do
    it "includes the bill due date" do
      bill_email.body.raw_source.should
        include bill.due_date
    end

    it "includes the total amount due" do
      bill_email.body.raw_source.should
        include bill.total_due
    end

    it "includes the individual amounts due" do
      bill.slices.each do |slice|
        bill_email.body.raw_source.should
          include slice.amount
      end
    end

    it "sends the mail" do
      expect {
        bill_email.deliver
      }.to change(ActionMailer::Base.deliveries, :count).by 1
    end
  end
end
