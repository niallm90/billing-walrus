require 'spec_helper'

describe Payment do

  let(:user) { FactoryGirl.build(:user) }

  let(:slice) { FactoryGirl.build(:slice, :user => user) }

  subject { FactoryGirl.build(:payment, :user => user, :slice => slice) }

  it "has the correct fields" do
    subject.user.should == user
    subject.slice.should == slice
    subject.amount.should == 1000
  end

  it "has an integer payment greater than zero" do
    lambda do
      Payment.create!(:amount => 0)
    end.should raise_exception(ActiveRecord::RecordInvalid, /greater than 0/)

    lambda do
      Payment.create!(:amount => 1.23)
    end.should raise_exception(ActiveRecord::RecordInvalid, /integer/)
  end

end
