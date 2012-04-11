require 'spec_helper'

describe VendorsController do

  context "when a user is not signed in" do
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:service) { FactoryGirl.create :service }
    let(:vendor) { FactoryGirl.create :vendor }

    before do
      sign_in_super_user
    end

    describe 'GET index' do
      before { get :index }

      specify { response.should be_success }

      specify { assigns(:vendors).should == Vendor.all }
    end

    describe 'GET show' do
      before { get :show, :id => vendor.id }

      specify { response.should be_success }

      specify { assigns(:vendor).should == vendor }
    end

    describe 'POST create' do
      it "creates a vendor" do
        lambda do
          post :create,
            :vendor => {
              :service_ids => [service],
              :name => "name"
            }
        end.should change(Vendor, :count).by 1

        response.should redirect_to vendors_url
        Vendor.last.services.should include(service)
      end

      it "fails to create invalid vendors" do
        post :create, :invalid => "invalid"
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before {
        @vendor = Vendor.new(FactoryGirl.attributes_for(:vendor))
        @vendor.save!
      }

      it "updates a vendor" do
        lambda do
          put :update, :id => Vendor.last.id,
            :vendor => {
              :name => "new name"
            }
          response.should redirect_to vendors_url
        end.should change{ Vendor.last.name }
      end
    end
  end
end
