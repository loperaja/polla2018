class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all.order(:email)
  end

  def update
    User.find(params[:id]).update_attributes(:admin => params[:admin])
    redirect_to admin_users_path
  end

end
