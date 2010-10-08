require 'test_helper'

class TaskHelperTest < ActionView::TestCase
  context "for task helper" do
    setup { @list = Factory(:list_with_item) }
    setup { @first_task = @list.tasks.first }
    
    context "for closed_class method" do
      setup { @first_task.closed = true }
      
      should "return class closed" do
        assert_equal "closed", closed_class(@first_task)
      end
      
      should "return nil" do
        @first_task.closed = false
        assert_nil link_class(@first_task)
      end
    end
  end
end
