class Admin::UserController < Admin::AdminController

  def index
    @users = User.all
  end

end
