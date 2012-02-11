require 'spec_helper'

describe BillsController do

  context "when a user is not signed in" do
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:bill) { FactoryGirl.create :bill }

    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    describe 'GET index' do
      before { get :index }

      specify { response.should be_success }

      specify { assigns(:bills).should == Bill.all }
    end

    describe 'GET show' do
      before { get :show, :id => bill.id }

      specify { response.should be_success }

      specify { assigns(:bill).should == bill }
    end
  end
end
