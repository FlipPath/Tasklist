class TasksController < ApplicationController
  before_filter :load_list
  before_filter :load_channel, :only => [:create, :update, :toggle_complete, :destroy, :reorder]
  before_filter :load_task, :only => [:toggle_complete, :destroy, :reorder, :update]
  
  respond_to :js
  
  def create
    @task = @list.tasks.create :task => params[:task][:task]
  end
  
  def update
    @task.update_attributes params[:task]
  end
  
  def toggle_complete
    @task.toggle_complete
  end
  
  def destroy
    @task.destroy
  end
  
  def reorder
    @task.move_to params[:position]
  end
  
  private
  
  def load_list
    @list = List.find(params[:list_id])
  end
  
  def load_task
    @task = @list.tasks.find(params[:id])
  end
  
  def load_channel
    @channel = Pusher["private-list-#{@list.id}"]
  end
end