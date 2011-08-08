class Admin::AdminController < ApplicationController

  before_filter :authenticate_user!, :check_admin_access

  layout 'admin'

  # Check if the user is logged in AND have admin_panel access
  def check_admin_access
    if current_user.can_access?(:admin_panel)
      return true
    else
      raise Exceptions::AccessDenied, "Access Denied"
    end
  end


end
