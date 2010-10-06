require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  
  context "the toggle complete method" do
    setup do
      @task = Factory(:task)
    end
    
    should "mark task closed" do
      @task.closed = false
      @task.toggle_close
      assert @task.closed
    end
    
    should "mark task incomplete" do
      @task.closed = true
      @task.toggle_close
      assert !@task.closed
    end
  end  
end
