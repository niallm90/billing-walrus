require 'spec_helper'

describe Bill do

  let(:vendor) { FactoryGirl.build(:vendor)}

  subject { FactoryGirl.build(:bill, :vendor => vendor) }

  it "has the correct fields" do
    subject.vendor.should == vendor
    subject.issue_date.should == DateTime.new(1000000)
    subject.due_date.should == DateTime.new(2000000)
  end

end
