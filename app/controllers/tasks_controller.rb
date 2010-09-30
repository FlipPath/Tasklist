class TasksController < ApplicationController
  before_filter :load_list
  before_filter :load_channel, :only => [:create, :toggle_complete, :destroy]
  before_filter :load_task, :only => [:toggle_complete, :destroy]
  
  def create
    @task = @list.tasks.create(:task => params[:task][:task])
    
    data = {
      :type => "tasks:create", :list_id => "#{@list.id}",
      :task_html => render_haml("task", :task => @task)
    };
    
    @channel.trigger("task-create", data, params[:socket_id])
    
    respond_to do |format|
      format.js { jq_trigger data }
    end
  end
  
  def toggle_complete
    @task.toggle_complete
    
    data = {
      :type => "tasks:complete", :task_id => "#{@task.id}",
      :task_html => render_haml("task", :task => @task)
    }
    
    @channel.trigger("task-toggle-complete", data);
    
    respond_to do |format|
      format.js { jq_trigger data }
    end
  end
  
  def destroy
    @task.destroy
    
    data = { :type => "tasks:destroy", :task_id => "#{@task.id}" }
    
    @channel.trigger("task-destroy", data);
    
    respond_to do |format|
      format.js { jq_trigger data }
    end
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