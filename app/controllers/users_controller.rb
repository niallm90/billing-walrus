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
      redirect_to @user
    else
      flash[:warning] = "There was a problem creating the User. Please try again."
      render :action => :new
    end
  end

  def dashboard
    @slices = current_user.slices
  end

end
