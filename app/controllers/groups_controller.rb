class GroupsController < ActionController::Base
  before_filter :authenticate_user!
  
  respond_to :html, :only => [:index]
  respond_to :js, :except => [:index]
  
  def index
    @groups = current_user.groups
  end
end