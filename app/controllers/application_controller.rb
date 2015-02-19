class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :debug_title if Rails.env.development?
  before_filter :actual_back
  include ActualBack

  def debug_header(text)
    bars = "=" *80
    Rails.logger.debug("\n\e[1;31m#{bars}\n#{text}\n#{bars}\e[0m")
  end

  def debug_title
    debug_header("#{params[:controller]} - #{params[:action]}")
  end

  def actual_back
    set_last_path request.env['PATH_INFO']
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticated
    unless current_user
      flash[:notice] = "You need to log in to visit that page"
      redirect_to root_path
    end
  end
  helper_method :authenticated

  def authenticated_super_admin
    unless current_user && current_user.super_admin?
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to root_path
    end
  end
  helper_method :authenticated_super_admin

  def authenticated_king
    unless current_user && current_user.king?
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to root_path
    end
  end
  helper_method :authenticated_king

  def my_breadcrumbs(obj)
    obj.parent_chain.each do |bc|
      if bc.id == nil
        add_breadcrumb bc.title, forums_path
      else
        add_breadcrumb bc.title.truncate(15), "/#{bc.class.to_s.downcase}s/#{bc.id}"
      end
    end
  end

  helper_method :last_path

end
