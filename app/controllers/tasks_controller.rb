class TasksController < ApplicationController
  def create
    @task = Task.create(:task => params[:task][:task])
    
    respond_to do |format|
      format.js
    end
  end
end