require 'test_helper'

class TaskHelperTest < ActionView::TestCase
  context "for task helper" do
    
    context "for link_class method" do
      setup { @task = Factory(:valid_task, :completed => true) }
      
      should "return class completed" do
        assert_equal "completed", link_class(@task)
      end
      
      should "return nil" do
        @task.completed = false
        assert_nil link_class(@task)
      end
    end
  end
end
