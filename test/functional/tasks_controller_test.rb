require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  context "for tasks controller" do
    setup { @list = Factory(:list_with_item) }
    setup { @first_task = @list.tasks.first }
    
    context "for create action" do
      setup { post(:create, :format => :js, :list_id => @list.id, :task => { :task => "Take out the garbage " }) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:create)
    end
    
    context "for complete action" do
      setup { put(:complete, :format => :js, :list_id => @list.id, :id => @first_task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:complete)
    end
    
    context "for destroy action" do
      setup { delete(:destroy, :format => :js, :list_id => @list.id, :id => @first_task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:destroy)
    end
  end
end
