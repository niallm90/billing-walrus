require 'spec_helper'

describe Vendor do

  subject { FactoryGirl.create(:vendor) }

  it { should belong_to :service }
  it { should have_many :bills }
  
  it "has the correct fields" do
    subject.name.should == "A vendor"
    subject.service.name.should == "A service"
  end

  it "has the correct relationship with bill" do
    subject.bills.class.should == Array

    expect {
      subject.bills << FactoryGirl.build(:bill)
      subject.save
      subject.reload
    }.should change(subject.bills, :count).by 1

    expect {
      old_bill = subject.bills.first
      old_bill.delete
    }.should change(subject.bills, :count).by -1
  end

end
