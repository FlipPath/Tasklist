require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  should validate_presence_of(:task)
  
  context "for complete method" do
    setup do
      @list = Factory(:list_with_item)
      @task = @list.tasks.first
      @task.completed = false
    end
    
    should "mark task completed" do
      @task.complete
      assert @task.completed
    end
  end
  
  context "for latest" do
    setup do
      @list = Factory(:empty_list)
      
      @first_task = @list.tasks.create(:task => "Love the way you lie")
      @first_task.created_at = 1.day.ago
      @first_task.save
      
      @second_task = @list.tasks.create(:task => "California Gurls")
      @second_task.created_at = Time.now
      @second_task.save
    end
    
    should "be order descending" do
      assert_equal [@second_task, @first_task], @list.tasks.latest
    end
  end
  
end
