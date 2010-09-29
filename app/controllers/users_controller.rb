class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.where(:username => params[:id]).first
  end

end
