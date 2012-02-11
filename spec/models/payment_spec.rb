require 'spec_helper'

describe Payment do

  let(:user) { FactoryGirl.build(:user) }

  let(:slice) { FactoryGirl.build(:slice, :user => user) }

  subject { FactoryGirl.build(:payment, :slice => slice) }

  it { should belong_to :slice }
  it { should belong_to :user }
  it { should validate_presence_of :slice }

  it "proxies user to slice" do
    subject.user.should == slice.user
  end

  it "has the correct fields" do
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
