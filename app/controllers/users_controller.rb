class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end
  
  def search
    @results = User.search(params[:q])
    
    respond_to do |format|
      format.json { render :json => @results }
    end
  end
end
