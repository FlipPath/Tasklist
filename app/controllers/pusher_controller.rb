class PusherController < ApplicationController
  protect_from_forgery :except => :index
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => :auth
  
  
  def auth
    if current_user.can_access_channel(params[:channel_name])
      @response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id,
        :user_info => {
          :username => current_user.username,
          :name => current_user.name,
          :email => current_user.email
        }
      })
      render :json => @response
    else
      render :text => "Invalid auth request", :status => :forbidden
    end
  end
end