class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end
  
  def search
    @users = User.search(params[:q]).reject {|u| u.id == current_user.id }
    
    respond_to do |format|
      format.json { render :json => @users }
    end
  end
end
