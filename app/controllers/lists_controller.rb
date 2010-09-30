class ListsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_lists
  before_filter :load_list, :only => [:destroy, :share]
  
  def index
    @lists = @lists.latest
  end
  
  def create
    @list = @lists.create(:name => params[:list][:name])
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @list.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def share
    @user = User.find(params[:username])
    @list.share(@user)
    
    respond_to do |format|
      format.js
    end
  end
    
  private
  
  def load_lists
    @lists = current_user.lists
  end
  
  def load_list
    @list = @lists.find(params[:id])
  end
end