class ApplicationController < ActionController::Base
  around_action :set_time_zone, if: :current_user
  before_action :authenticate_user!
  layout :layout_by_resource


  private

  def layout_by_resource
    if devise_controller?
      "clean"
    else
      "application"
    end
  end

  def set_time_zone(&block)
    Time.use_zone(current_user.timezone, &block)
  end

end
