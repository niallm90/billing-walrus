require 'spec_helper'

describe Service do

  subject { FactoryGirl.build(:service) }

  it { should have_many :vendors }

  it "should have a name" do
    subject.name.should == "A service"
  end

  it "should have_many vendors" do
    subject.vendors.class.should == Array
  end

  it "should allow vendors to be added and deleted" do
    expect {
      new_vendor = subject.vendors.build
      new_vendor.save!
    }.should change(subject.vendors, :count).by 1

    expect {
      existing_vendor = subject.vendors.first
      existing_vendor.delete
    }.should change(subject.vendors, :count).by -1
  end

end
