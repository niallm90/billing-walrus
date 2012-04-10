require 'spec_helper'

describe PaymentsController do

  context "when a user is not signed in" do
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:payment) { FactoryGirl.create :payment }
    let(:slice) { FactoryGirl.create :slice }

    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    describe 'GET index' do
      before { get :index }

      specify { response.should be_success }

      specify { assigns(:payments).should == Payment.all }
    end

    describe 'GET show' do
      before { get :show, :id => payment.id }

      specify { response.should be_success }

      specify { assigns(:payment).should == payment }
    end

    describe 'POST create' do
      it "creates a payment" do
        lambda do
          post :create,
            :payment => {
              :slice_id => slice.id,
              :amount => 100
            }
        end.should change(Payment, :count).by 1

        response.should redirect_to slice_url(slice, :bill_id => slice.bill.id)
        Payment.last.slice.should == slice
      end

      it "fails to create invalid payments" do
        post :create, :invalid => "invalid"
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before {
        @payment = Payment.new(FactoryGirl.attributes_for(:payment))
        @payment.slice_id = FactoryGirl.create(:slice).id
        @payment.save!
      }

      it "updates a payment" do
        lambda do
          payment = Payment.last
          put :update, :bill_id => payment.slice.bill.id, :slice_id => payment.slice.id, :id => payment.id,
            :payment => {
              :amount => 200
            }
        end.should change{ Payment.last.amount }
      end
    end

    describe 'DELETE destroy' do
      before(:each) {
        @payment = FactoryGirl.create :payment
        @payment.slice_id = FactoryGirl.create(:slice).id
        @payment.save!
      }

      it "deletes a payment" do
        lambda do
          delete :destroy, :id => @payment.id
          response.should redirect_to slice_url(@payment.slice.bill, @payment.slice)
        end.should change(Payment, :count).by(-1)
      end
    end

  end
end
