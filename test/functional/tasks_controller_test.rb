require 'test_helper'

class TasksControllerTest < ActionController::TestCase  
  context "the tasks controller" do
    setup do
      @task = Factory(:task)
      @list = @task.list
    end
    
    context "for create action" do
      setup { post(:create, :format => :js, :list_id => @list.id, :task => { :title => "Take out the garbage " }) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:create)
    end
    
    context "toggle complete action" do
      setup { put(:toggle_close, :format => :js, :list_id => @list.id, :id => @task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:toggle_close)
    end
    
    context "for destroy action" do
      setup { delete(:destroy, :format => :js, :list_id => @list.id, :id => @task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:destroy)
    end
    
    context "for insert_at action" do
      setup do
        @task = @list.tasks.first

        put(:insert_at, :format => :js, :id => @task.id, :list_id => @list.id, :position => "2")
      end

      should respond_with :ok
    end
  end
end
