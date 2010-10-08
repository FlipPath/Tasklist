class ListsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_lists
  before_filter :load_list, :only => [:index, :update, :destroy, :share]
  
  respond_to :html, :only => [:index]
  respond_to :js, :except => [:index]
  
  def index
    respond_with @lists = @lists.latest
  end
  
  def create
    @list = @lists.create(:name => params[:list][:name])
  end
  
  def update
    @list.update_attributes(params[:list])
  end
  
  def destroy
    @list.destroy
  end
  
  def share
    @user = User.find(params[:username])
    @list.share(@user)
  end
    
  private
  
  def load_lists
    @lists = current_user.lists
  end
  
  def load_list
    @list = @lists.find(params[:id] ? params[:id] : @lists.last)
  end
end