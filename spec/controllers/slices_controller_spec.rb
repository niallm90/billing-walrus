
require 'spec_helper'

describe SlicesController do

  context "when a user is not signed in" do
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:slice) { FactoryGirl.create :slice }
    let(:bill) { FactoryGirl.create :bill }

    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    describe 'GET show' do
      before { get :show, :id => slice.id }

      specify { response.should be_success }

      specify { assigns(:slice).should == slice }
    end

    describe 'POST create' do
      it "creates a slice" do
        lambda do
          post :create, :slice => {
              :user_id => @user.id,
              :amount => 100,
              :bill_id => bill.id
            }
        end.should change(Slice, :count).by 1

        response.should redirect_to bill_url Slice.last.bill
        Slice.last.bill.should == bill
      end

      it "fails to create invalid slices" do
        post :create, :invalid => "invalid"
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before {
        @slice = FactoryGirl.create(:slice)
        @slice.bill_id = FactoryGirl.create(:bill).id
        @slice.save!
      }

      it "updates a slice" do
        lambda do
          put :update, :id => Slice.last.id,
            :slice => {
              :amount => 500
            }
        end.should change{ Slice.last.amount }
      end
    end

    describe 'DELETE destroy' do
      before(:each) {
        @slice = FactoryGirl.create :slice
        @slice.bill_id = FactoryGirl.create(:bill).id
        @slice.save!
      }

      it "deletes a slice" do
        lambda do
          delete :destroy, :id => @slice.id
          response.should redirect_to @slice.bill
        end.should change(Slice, :count).by(-1)
      end

      it "deletes the payments associated with the slice" do
        payment = FactoryGirl.create :payment
        @slice.payments << payment
        @slice.save!
        lambda do
          delete :destroy, :id => @slice.id
          response.should redirect_to @slice.bill
        end.should change(Payment, :count).by(-1)
      end
    end
  end
end
