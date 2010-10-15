class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_groups
  before_filter :load_group, :only => [:show, :insert_at]
  
  respond_to :html, :only => [:index]
  respond_to :js, :except => [:index]
  
  def index
    @group = @groups.first
    @lists = @group.lists if @group
    @list = @lists.first if @lists
    redirect_to @list ? group_list_url(@group, @list) : @group 
  end
  
  def insert_at
    @group.insert_at params[:position]
  end
  
  private
  
  def load_groups
    @groups = current_user.groups
  end
  
  def load_group
    @group = @groups.find(params[:id])
    @lists = @group.lists
  end
end