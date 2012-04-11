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

  it "should set the default access_level" do
    user = FactoryGirl.create(:user)
    user.reload
    user.access_level.should == User::UNVERIFIED
  end

  describe "permissions for" do
    describe "an unvalidated user" do
      before { subject.access_level = User::UNVERIFIED }

      it "is not a user" do
        subject.verified?.should be_false
      end

      it "is not an admin" do
        subject.admin?.should be_false
      end

      it "is not a super user" do
        subject.super_user?.should be_false
      end
    end

    describe "a user" do
      before { subject.access_level = User::VERIFIED }

      it "is a user" do
        subject.verified?.should be_true
      end

      it "is not an admin" do
        subject.admin?.should be_false
      end

      it "is not a super user" do
        subject.super_user?.should be_false
      end
    end

    describe "an admin" do
      before { subject.access_level = User::ADMIN }

      it "is a user" do
        subject.verified?.should be_true
      end

      it "is an admin" do
        subject.admin?.should be_true
      end

      it "is not a super user" do
        subject.super_user?.should be_false
      end
    end

    describe "a super user" do
      before { subject.access_level = User::SUPER_USER }

      it "is a user" do
        subject.verified?.should be_true
      end

      it "is an admin" do
        subject.admin?.should be_true
      end

      it "is a super user" do
        subject.super_user?.should be_true
      end
    end
  end

end
