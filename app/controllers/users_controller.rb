class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  def create
  end

  def edit
  end

  def show
  end

  def dashboard
    @slices = current_user.slices
  end

end
