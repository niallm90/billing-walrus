require 'spec_helper'

describe User do

  subject { FactoryGirl.build(:user) }

  it { should have_many :slices }
  it { should have_many :bills }

  it "returns the access_levels array that the current user may assign" do
    expected_access_for = {
      User::ADMIN => {
        User::UNVERIFIED => "Unverified",
        User::VERIFIED => "Verified"
      },
      User::SUPER_USER => {
        User::UNVERIFIED => "Unverified",
        User::VERIFIED => "Verified",
        User::ADMIN => "Admin"
      }
    }
    [User::ADMIN, User::SUPER_USER].each do |level|
      user = FactoryGirl.build(:user, :access_level => level)
      user.assignable_access_levels.should == expected_access_for[level]
    end
  end

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

  it "should return the access_level in human readable form" do
    {
      User::UNVERIFIED => "Unverified",
      User::VERIFIED => "Verified",
      User::ADMIN => "Admin",
      User::SUPER_USER => "Super User"
    }.each do |access_constant, human_readable|
      subject.should_receive(:access_level).and_return(access_constant)
      subject.display_access_level.should == human_readable
    end
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
