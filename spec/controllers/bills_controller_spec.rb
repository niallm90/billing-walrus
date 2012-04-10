require 'spec_helper'

describe BillsController do

  context "when a user is not signed in" do
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:bill) { FactoryGirl.create :bill }
    let(:vendor) { FactoryGirl.create :vendor }

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

    describe 'POST create' do
      it "creates a bill" do
        lambda do
          post :create,
            :bill => {
              :vendor_id => vendor.id,
              :issue_date => Time.now,
              :due_date => Time.now+20.days
            }
        end.should change(Bill, :count).by 1

        response.should redirect_to bill_url Bill.last.id
        Bill.last.vendor.should == vendor
      end

      it "fails to create invalid bills" do
        post :create, :invalid => "invalid"
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before {
        @bill = Bill.new(FactoryGirl.attributes_for(:bill))
        @bill.vendor_id = FactoryGirl.create(:vendor).id
        @bill.save!
      }

      it "updates a bill" do
        lambda do
          put :update, :id => Bill.last.id,
            :bill => {
              :due_date => Bill.last.due_date+50
            }
        end.should change{ Bill.last.due_date }
      end
    end

    describe 'DELETE destroy' do
      before(:each) {
        @bill = Bill.new(FactoryGirl.attributes_for(:bill))
        @bill.vendor_id = FactoryGirl.create(:vendor).id
        @bill.save!
      }

      it "deletes a bill" do
        lambda do
          delete :destroy, :id => @bill.id
          response.should redirect_to bills_url
        end.should change(Bill, :count).by(-1)
      end

      it "deletes the slices associated with the bill" do
        slice = FactoryGirl.create :slice
        @bill.slices << slice
        @bill.save!
        lambda do
          delete :destroy, :id => @bill.id
          response.should redirect_to bills_url
        end.should change(Slice, :count).by(-1)
      end
    end
  end
end
