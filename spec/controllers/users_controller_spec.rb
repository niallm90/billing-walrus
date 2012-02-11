require 'spec_helper'

describe UsersController do

  let(:slices) { mock(:to_a => []) }

  context "when a user is not signed in" do
    specify { get(:dashboard).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do
    before do
      @user = FactoryGirl.create :user
      User.any_instance.stub(:slices).and_return slices
      sign_in @user
    end

    describe "GET dashboard" do
      before { get :dashboard }

      specify { response.should be_success }

      specify { assigns(:slices).should == [] }
    end
  end

end
