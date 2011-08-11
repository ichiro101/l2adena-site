class UsersController < ApplicationController

  before_filter :get_requested_url, :only => [:dismiss_newbie_bar]

  def dismiss_newbie_bar
    session[:hide_newbie_bar] = true
    redirect_to session[:return_to]
    session[:return_to] = nil
  end

  private

  def get_requested_url
    session[:return_to] ||= request.referrer
  end

end
