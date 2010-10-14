require 'test_helper'

class TaskHelperTest < ActionView::TestCase
  context "for task helper" do
    setup { @task = Factory(:task) }
    
    context "for closed_class method" do
      setup { @task.closed = true }
      
      should "return class closed" do
        assert_equal "closed", closed_class(@task)
      end
      
      should "return nil" do
        @task.closed = false
        assert_nil closed_class(@task)
      end
    end
  end
end
