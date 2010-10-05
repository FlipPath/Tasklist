require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  context "the tasks controller" do
    setup do
      @user = Factory(:user)
      @list = @user.lists.create(Factory.build(:list_with_item).attributes)
      @first_task = @list.tasks.first
    end
    
    context "for create action" do
      setup { post(:create, :format => :js, :list_id => @list.id, :task => { :task => "Take out the garbage " }) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:create)
    end
    
    context "toggle complete action" do
      setup { put(:toggle_close, :format => :js, :list_id => @list.id, :id => @first_task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:toggle_close)
    end
    
    context "for destroy action" do
      setup { delete(:destroy, :format => :js, :list_id => @list.id, :id => @first_task.id) }
      
      should assign_to(:task).with_kind_of(Task)
      
      should render_template(:destroy)
    end
  end
end
