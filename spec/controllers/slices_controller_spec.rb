require 'spec_helper'

describe SlicesController do

  let(:slice) { FactoryGirl.create :slice }
  let(:bill) { FactoryGirl.create :bill }

  context "when a user is not signed in" do
    specify { get(:show, :id => slice.id, :bill_id => bill.id).should redirect_to new_user_session_url }
    specify { get(:new, :bill_id => bill.id).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    before do
      sign_in_super_user
    end

    describe 'GET show' do
      before { get :show, :id => slice.id, :bill_id => bill.id }

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
            }, :bill_id => bill.id
        end.should change(Slice, :count).by 1

        response.should redirect_to bill_url Slice.last.bill
        Slice.last.bill.should == bill
      end

      it "fails to create invalid slices" do
        post :create, :bill_id => bill.id,:invalid => "invalid"
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
        slice = Slice.last
        lambda do
          put :update, :id => slice.id, :bill_id => slice.bill_id,
            :slice => {
              :amount => 500
            }
          slice.reload
        end.should change{ slice.amount }
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
          delete :destroy, :id => @slice.id, :bill_id => @slice.bill.id
          response.should redirect_to @slice.bill
        end.should change(Slice, :count).by(-1)
      end

      it "deletes the payments associated with the slice" do
        payment = FactoryGirl.create :payment
        @slice.payments << payment
        @slice.save!
        lambda do
          delete :destroy, :id => @slice.id, :bill_id => @slice.bill.id
          response.should redirect_to @slice.bill
        end.should change(Payment, :count).by(-1)
      end
    end
  end
end
