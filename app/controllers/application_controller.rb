class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def jq_trigger(data)
    render :js => "$(document).trigger(#{data.to_json});"
  end
  
  def render_haml(partial, locals={})
    render_to_string :partial => "#{partial}.html.haml", :locals => locals
  end
end
