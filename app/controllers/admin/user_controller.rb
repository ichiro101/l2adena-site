class Admin::UserController < Admin::AdminController

  def get_profile
    if @user.profile.nil?
      @profile = Profile.new
    else
      @profile = @user.profile
    end
  end

  def update_profile
  end

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "User has been deleted from the database, please note the associated game accounts were NOT deleted"
    redirect_to admin_user_index_path
  end

end
