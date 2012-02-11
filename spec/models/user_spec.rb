require 'spec_helper'

describe User do

  subject { FactoryGirl.build(:user) }

  it { should have_many :slices }
  it { should have_many :bills }

  it "has many slices" do
    subject.slices.class.should == Array
  end

  it "has many bills through slices" do
    subject.bills.class.should == Array
  end

end
