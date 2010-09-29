class ListsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @lists = current_user.lists.latest
  end
  
  def create
    @list = current_user.lists.create(:name => params[:list][:name])
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy
    
    respond_to do |format|
      format.js
    end
  end
end