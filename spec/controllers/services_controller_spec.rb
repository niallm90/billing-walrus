require 'spec_helper'

describe ServicesController do

  context "when a user is not signed in" do
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do

    let(:service) { FactoryGirl.create :service }

    before do
      sign_in_super_user
    end

    describe 'GET index' do
      before { get :index }

      specify { response.should be_success }

      specify { assigns(:services).should == Service.all }
    end

    describe 'GET show' do
      before { get :show, :id => service.id }

      specify { response.should be_success }

      specify { assigns(:service).should == service }
    end

    describe 'POST create' do
      it "creates a service" do
        lambda do
          post :create,
            :service => {
              :name => "name"
            }
        end.should change(Service, :count).by 1

        response.should redirect_to services_url
        Service.last.name.should == "name"
      end

      it "fails to create invalid services" do
        post :create, :invalid => "invalid"
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before {
        @service = Service.new(FactoryGirl.attributes_for(:service))
        @service.save!
      }

      it "updates a service" do
        lambda do
          put :update, :id => Service.last.id,
            :service => {
              :name => "a new name"
            }
          response.should redirect_to services_url
        end.should change{ Service.last.name }
      end
    end
  end
end
