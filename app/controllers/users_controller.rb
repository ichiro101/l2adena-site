class UsersController < ApplicationController

  before_filter :get_requested_url, :only => [:dismiss_newbie_bar, :undismiss_newbie_bar]
  before_filter :authenticate_user!, :except => [:dismiss_newbie_bar, :undismiss_newbie_bar]

  def get_profile
    if current_user.profile.nil?
      @profile = Profile.new
    else
      @profile = current_user.profile
    end
  end

  def update_profile
  end

  def dismiss_newbie_bar
    session[:hide_newbie_bar] = true
    redirect_to session[:return_to]
    flash[:info] = "I have hidden the newbie instructions and I hope you got Lineage 2 working, if you want the instructions again, click Re-show Connection Instructions link on the bottom."
    session[:return_to] = nil
  end

  def undismiss_newbie_bar
    session[:hide_newbie_bar] = nil
    redirect_to session[:return_to]
    session[:return_to] = nil
  end

  private

  def get_requested_url
    session[:return_to] ||= request.referrer
  end

end
