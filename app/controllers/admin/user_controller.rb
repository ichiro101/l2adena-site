class Admin::UserController < Admin::AdminController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:user])
  end

end
