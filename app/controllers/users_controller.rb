class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to users_url
    else
      flash[:warning] = "There was a problem creating the User. Please try again."
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if !params[:user][:password].nil? and params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if !params[:user][:access_level].nil? and params[:user][:access_level].to_i >= current_user.access_level
      params[:user].delete(:access_level)
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User successfully updated'
      redirect_to users_url
    else
      flash[:warning] = 'There was a problem'
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:notice] = 'User was successfully deleted.'
    else
      flash[:warning] = 'There was a problem.'
    end
    redirect_to users_url
  end

  def dashboard
    @slices = current_user.slices
  end

end
