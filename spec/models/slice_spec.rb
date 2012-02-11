require 'spec_helper'

describe Slice do

  let(:user) { FactoryGirl.build(:user) }

  subject { FactoryGirl.build(:slice, :user => user) }

  it { should belong_to :user }
  it { should belong_to :bill }
  it { should have_many :payments }
  it { should validate_presence_of :user }
  it { should validate_presence_of :bill }

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

  it "should return the total amount paid towards this slice" do
    subject.total_paid.should == 0
    subject.payments.build(:amount => 10, :user => subject.user)
    subject.total_paid.should == 10
  end

end
