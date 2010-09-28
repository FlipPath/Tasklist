require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  should validate_presence_of(:task)
  
  context "for complete method" do
    setup { @task = Factory(:valid_task, :completed => false) }
    
    should "mark task completed" do
      @task.complete
      assert @task.completed
    end
  end
  
  context "for latest" do
    setup do
      Task.destroy_all
      @first_task = Factory(:valid_task, :created_at => Time.now)
      @second_task = Factory(:valid_task, :created_at => 1.day.ago)
    end
    
    should "be order descending" do
      assert_same_elements [@second_task, @first_task], Task.latest.to_a
    end
  end
  
end
