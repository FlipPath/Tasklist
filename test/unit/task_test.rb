require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  
  context "the toggle complete method" do
    setup do
      @user = Factory(:user)
      @list = @user.lists.create(Factory.build(:list_with_item).attributes)
      @task = @list.tasks.first
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
  
  context "for insert_at" do
    
    context "to move task up" do
      setup do
        @list = Factory(:list_with_ten_items)
        @list.tasks.second.insert_at(7)
      end
      
      should "place task 2 at position 7" do
        assert_equal [0, 7, 1, 2, 3, 4, 5, 6, 8, 9], @list.tasks.map(&:position)
      end
    end
    
    context "to move task down" do
      setup do
        @list = Factory(:list_with_ten_items)
        @list.tasks[7].insert_at(3)
      end
      
      should "place task 7 at position 3" do
        assert_equal [0, 1, 2, 4, 5, 6, 7, 3, 8, 9], @list.tasks.map(&:position)
      end
    end
    
    context "to move task out of positively bounds" do
      setup do
        @list = Factory(:list_with_ten_items)
        @list.tasks[7].insert_at(1000)
      end
      
      should "move to top position" do
        assert_equal [0, 1, 2, 3, 4, 5, 6, 9, 7, 8], @list.tasks.map(&:position)
      end
    end
    
    context "to move task out of negatively bounds" do
      setup do
        @list = Factory(:list_with_ten_items)
        @list.tasks[7].insert_at(-1000)
      end
      
      should "move to bottom position" do
        assert_equal [1, 2, 3, 4, 5, 6, 7, 0, 8, 9], @list.tasks.map(&:position)
      end
    end
  end
  
end
