class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied, :with => :render_forbidden

  def render_forbidden(exception)
    if user_signed_in?
      redirect_to root_url, :alert => exception.message
    else
      redirect_to new_user_session_path
    end
  end
end
