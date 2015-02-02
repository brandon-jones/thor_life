class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticated
    unless current_user
      flash[:notice] = "You need to log in to visit that page"
      redirect_to '/login'
    end
  end

  def authenticated_super_admin
    unless current_user && current_user.super_admin?
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to '/login'
    end
  end

end
