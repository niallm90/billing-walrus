require 'spec_helper'

describe Bill do

  let(:vendor) { FactoryGirl.build(:vendor)}

  subject { FactoryGirl.build(:bill, :vendor => vendor, :issue_date => DateTime.new(1000000), :due_date => DateTime.new(2000000)) }

  it { should belong_to :vendor }
  it { should have_many :slices }
  it { should have_many :payments }
  it { should validate_presence_of :vendor }
  it { should validate_presence_of :issue_date }
  it { should validate_presence_of :due_date }

  it "has the correct fields" do
    subject.vendor.should == vendor
    subject.issue_date.should == DateTime.new(1000000)
    subject.due_date.should == DateTime.new(2000000)
  end

  it "returns the total amount due" do
    subject.slices = FactoryGirl.build_list(:slice, 5, :amount => 10, :user => nil, :bill => subject)
    subject.total_due.should == 50
  end

  it "returns the total amount paid" do
    subject.total_paid.should == 0
    subject.payments.build(:amount => 10)
    subject.total_paid.should == 10
  end

end
