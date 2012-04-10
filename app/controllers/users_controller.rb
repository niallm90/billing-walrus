class UsersController < ApplicationController

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
