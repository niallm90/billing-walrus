require 'spec_helper'

describe Vendor do

  let(:service) { Service.new(:name => "foo") }

  subject { Vendor.new(:name => "a vendor", :service => service, :contact_details => "some contact details") }

  it "has the correct fields" do
    subject.name.should == "a vendor"
    subject.service.name.should == "foo"
  end

  it "has the correct relationship with bill" do
    subject.bills.class.should == Array

    expect {
      bill = subject.bills.build
      bill.save
    }.should change(subject.bills, :count).by 1

    expect {
      old_bill = subject.bills.first
      old_bill.delete
    }.should change(subject.bills, :count).by -1
  end

end
