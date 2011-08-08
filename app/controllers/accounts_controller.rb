# Handles the login and account registration the traditional way. Once
# the user is signed in, the user will be redirected to the main page
#
# TODO: Actual login system
class AccountsController < ApplicationController

  def signin
    username = params[:username]
    password = params[:password]

    user = User.authenticate(username, password)

    if user
      session[:user_id] = user.id
      flash[:notice] = "You have been signed in"
      redirect_to root_url
    else
      flash[:error] = "Invalid username/password combination"
      redirect_to signin_services_path
    end
  end

  def register
    @user = User.new
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.email = params[:user][:email]
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your account has been created and you have been signed in"
      redirect_to root_url
    else
      render register_services_path
    end
  end

end
