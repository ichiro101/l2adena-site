class Admin::UserController < Admin::AdminController


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
