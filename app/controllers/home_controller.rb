class HomeController < ApplicationController
  def index
    redirect_to lists_url and return if current_user.present?
    @users = User.all
  end
end
