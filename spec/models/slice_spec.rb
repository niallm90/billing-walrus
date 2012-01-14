require 'spec_helper'

describe Slice do

  let(:user) { FactoryGirl.build(:user) }

  subject { FactoryGirl.build(:slice, :user => user) }

  it "has the correct fields" do
    subject.user.should == user
    subject.amount.should == 1000
  end

  it "has an integer payment greater than zero" do
    lambda do
      Slice.create!(:amount => 0)
    end.should raise_exception(ActiveRecord::RecordInvalid, /greater than 0/)

    lambda do
      Slice.create!(:amount => 1.23)
    end.should raise_exception(ActiveRecord::RecordInvalid, /integer/)
  end

end
