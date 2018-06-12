class ApplicationController < ActionController::Base
  config.time_zone = "UTC"
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

end
