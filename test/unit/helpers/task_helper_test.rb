require 'test_helper'

class TaskHelperTest < ActionView::TestCase
  context "for task helper" do
    setup { @list = Factory(:list_with_item) }
    setup { @first_task = @list.tasks.first }
    
    context "for link_class method" do
      setup { @first_task.completed = true }
      
      should "return class completed" do
        assert_equal "completed", link_class(@first_task)
      end
      
      should "return nil" do
        @first_task.completed = false
        assert_nil link_class(@first_task)
      end
    end
  end
end
