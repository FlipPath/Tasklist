class TasksController < ApplicationController
  before_filter :load_list
  before_filter :load_task, :only => [:complete, :destroy]
  
  def create
    @task = @list.tasks.create(:task => params[:task][:task])
    
    respond_to do |format|
      format.js
    end
  end
  
  def complete
    @task.complete
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @task.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def load_list
    @list = List.find(params[:list_id])
  end
  
  def load_task
    @task = @list.tasks.find(params[:id])
  end
end