class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :check_access

  rescue_from Exceptions::AccessDenied, :with => :access_denied
  rescue_from Exceptions::PageNotExistException, :with => :page_not_found

  private

  def page_not_found
    flash[:error] = "The page you were looking for is not found"
    redirect_to root_url
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return 1 if current_user
  end

  def authenticate_user!
    if !current_user
      flash[:error] = "You need to sign in before accessing this page!"
      redirect_to signin_services_path
    end
  end

  def object_belongs_to_user(object)
    user_id = object.user_id
    raise Exceptions::AccessDenied if session[:user_id] != user_id
    true
  end

  def access_denied
    flash[:error] = "You do not have permission to access this resource"
    redirect_to root_url
  end

  def check_access(permission)
    if current_user.can_access?(permission)
      return true
    else
      raise Exceptions::AccessDenied, "Access Denied"
    end
  end
end
