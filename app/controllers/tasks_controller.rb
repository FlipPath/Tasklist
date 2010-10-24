class TasksController < ApplicationController
  before_filter :load_group
  before_filter :load_list
  before_filter :load_task, :only => [:toggle_close, :toggle_important, :destroy, :insert_at, :update]  
  
  respond_to :js
  
  def create
    @task = @list.tasks.create :title => params[:task][:title]
  end
  
  def update
    @task.update_attributes params[:task]
  end
  
  def toggle_close
    @task.toggle_close
  end
  
  def toggle_important
    @task.toggle_important
  end
  
  def destroy
    @task.destroy
  end
  
  def insert_at
    @task.insert_at params[:position]
  end
  
  private
  
  def load_group
    @group = current_user.groups.find(params[:group_id])
  end
  
  def load_list
    @list = @group.lists.find(params[:list_id])
  end
  
  def load_task
    @task = @list.tasks.find(params[:id])
  end
end