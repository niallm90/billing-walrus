require 'spec_helper'

describe UsersController do

  let(:slices) { mock(:to_a => []) }

  context "when a user is not signed in" do
    specify { get(:dashboard).should redirect_to new_user_session_url }
    specify { get(:index).should redirect_to new_user_session_url }
    specify { get(:show, :id => 1).should redirect_to new_user_session_url }
    specify { get(:new).should redirect_to new_user_session_url }
    specify { get(:edit, :id => 1).should redirect_to new_user_session_url }
  end

  context "when a user is signed in" do
    before do
      sign_in_super_user
      User.any_instance.stub(:slices).and_return slices
    end

    describe "GET dashboard" do
      before { get :dashboard }

      specify { response.should be_success }

      specify { assigns(:slices).should == slices }
    end

    describe "GET index" do
      before { get :index }

      specify { response.should be_success }
      specify { assigns(:users).should == User.all }
    end

    describe "GET show" do
      before { get :show, :id => User.first.id }

      specify { assigns(:user).should == User.first }
      specify { response.should be_success }
      specify { response.should render_template "users/show" }
    end

    describe "GET new" do
      before { get :new }

      specify { assigns(:user).should be_instance_of User }
      specify { response.should be_success }
      specify { response.should render_template "users/new" }
    end

    describe "POST create" do
      it "creates a user" do
        lambda do
          post :create,
            :user => FactoryGirl.attributes_for(:user)

          response.should redirect_to users_url
        end.should change(User, :count).by 1
      end

      it "does not create a user with invalid attributes" do
        lambda do
          post :create,
            :user => { :invalid => "attribute" }

          response.should render_template "new"
        end.should_not change(User, :count)
      end
    end

    describe 'PUT update' do
      before {
        @temp_user = User.create(FactoryGirl.attributes_for(:user))
      }

      it "updates a user" do
        lambda do
          put :update, :id => @temp_user,
            :user => {
              :name => "new name"
            }
          @temp_user.reload
          response.should redirect_to users_url
        end.should change{ @temp_user.name }
      end

      it "does not update a user with invalid attributes" do
        lambda do
          put :update, :id => @temp_user,
            :user => {
              :invalid => "attributes"
            }
          @temp_user.reload
        end.should_not change{ @temp_user.name }
      end

      it "removes invalid attributes" do
        lambda do
          put :update, :id => @temp_user,
            :user => {
              :access_level => "5"
            }
          @temp_user.reload
        end.should_not change{ @temp_user.access_level }

        lambda do
          put :update, :id => @temp_user,
            :user => {
              :password => "",
              :password_confirmation => ""
            }
          @temp_user.reload
        end.should_not change{ @temp_user.password }
      end
    end

    describe 'DELETE destroy' do
      before(:each) {
        @temp_user = FactoryGirl.create :user
      }

      it "deletes a user" do
        lambda do
          delete :destroy, :id => @user.id
          response.should redirect_to users_url
        end.should change(User, :count).by(-1)
      end
    end
  end

end
