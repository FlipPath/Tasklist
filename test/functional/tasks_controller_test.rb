require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  context "task controller" do
    
    context "for index action" do
      setup { get(:index) }
      
      should respond_with(:success)
    end
    
    context "for create action" do
      setup { post(:create, :format => :js, :task => { :task => "Take out the garbage " }) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:create)
    end
    
    context "for complete action" do
      setup { @task = Factory(:valid_task) }
      setup { put(:complete, :format => :js, :id => @task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:complete)
    end
    
    context "for destroy action" do
      setup { @task = Factory(:valid_task) }
      setup { delete(:destroy, :format => :js, :id => @task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:destroy)
    end
  end
end
