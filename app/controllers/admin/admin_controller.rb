class Admin::AdminController < ActionController::Base
  before_action :verify_admin
  layout :layout_by_resource


  private

  def layout_by_resource
    if devise_controller?
      "clean"
    else
      "admin"
    end
  end

  def verify_admin
    if current_user
      redirect_to home_index_path unless current_user.admin?
    else
      redirect_to new_user_session_path
    end
  end

end
