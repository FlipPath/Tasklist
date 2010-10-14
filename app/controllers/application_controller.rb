class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? || controller_name == "home"
      "home"
    else
      "application"
    end
  end
end
