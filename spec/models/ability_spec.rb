require "spec_helper"
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }

    context "when is an unverified user" do
      let(:user) { FactoryGirl.create(:user, {:access_level => User::UNVERIFIED}) }

      [User.new, Bill.new, Payment.new, Service.new, Slice.new, Vendor.new].each do |resource|
        it { should_not be_able_to(:read, resource) }
        it { should_not be_able_to(:create, resource) }
        it { should_not be_able_to(:update, resource) }
        it { should_not be_able_to(:destroy, resource) }
      end
    end

    context "when is a verified user" do
      let(:user) { FactoryGirl.create(:user, {:access_level => User::VERIFIED}) }

      it { should be_able_to(:read, :all) }
    end

    context "when is an admin" do
      let(:user) { FactoryGirl.create(:user, {:access_level => User::ADMIN}) }

      it { should be_able_to(:read, :all) }

      [Bill.new, Payment.new, Service.new, Slice.new, Vendor.new].each do |resource|
        it { should be_able_to(:manage, resource) }
      end
    end

    context "when is a super user" do
      let(:user) { FactoryGirl.create(:user, {:access_level => User::SUPER_USER}) }

      it { should be_able_to(:manage, :all) }
    end
  end
end
